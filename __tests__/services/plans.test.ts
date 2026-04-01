import {
  fetchUserPlans,
  fetchPlanById,
  createPlan,
  updatePlan,
  deletePlan,
  toggleChecklistItem,
  addChecklistItem,
  deleteChecklistItem,
  completePlan,
} from "../../src/services/plans";
import { supabase } from "../../src/services/supabase";

// ── Mocks ────────────────────────────────────────────────────────────

jest.mock("../../src/services/supabase", () => ({
  supabase: {
    from: jest.fn(),
    auth: {
      getUser: jest.fn(),
      getSession: jest.fn(),
    },
  },
}));

jest.mock("../../src/services/helpers", () => ({
  getCurrentUser: jest.fn(),
  getCurrentUserId: jest.fn(),
}));

const mockFrom = supabase.from as jest.Mock;

const { getCurrentUser } = jest.requireMock("../../src/services/helpers") as {
  getCurrentUser: jest.Mock;
};

// Chainable Supabase query mock
function buildChain(finalResult: {
  data?: unknown;
  error?: { message: string; code?: string } | null;
}) {
  const chain: Record<string, jest.Mock> = {};
  const methods = [
    "select",
    "insert",
    "update",
    "delete",
    "eq",
    "order",
    "limit",
    "single",
    "maybeSingle",
  ];
  methods.forEach((m) => {
    chain[m] = jest.fn().mockReturnValue(chain);
  });
  // Terminal calls
  chain.single = jest.fn().mockResolvedValue(finalResult);
  // For non-single queries (arrays), resolve directly from order/eq
  chain.order = jest.fn().mockImplementation(() => {
    // Return chain for further chaining but also make it thenable
    const thenableChain = { ...chain };
    (thenableChain as Record<string, unknown>).then = (
      resolve: (v: unknown) => void,
    ) => {
      resolve(finalResult);
      return thenableChain;
    };
    return thenableChain;
  });
  return chain;
}

// Simpler chain that resolves at any terminal
function simpleChain(finalResult: {
  data?: unknown;
  error?: { message: string; code?: string } | null;
}) {
  const resolve = () => Promise.resolve(finalResult);
  const chain: Record<string, jest.Mock> = {};
  const methods = [
    "select",
    "insert",
    "update",
    "delete",
    "eq",
    "order",
    "limit",
    "single",
    "maybeSingle",
  ];
  methods.forEach((m) => {
    chain[m] = jest.fn().mockReturnValue(chain);
  });
  chain.single = jest.fn().mockImplementation(resolve);
  // Make the chain itself thenable for array returns
  (chain as Record<string, unknown>).then = (
    onFulfilled: (v: unknown) => void,
    onRejected?: (e: unknown) => void,
  ) => Promise.resolve(finalResult).then(onFulfilled, onRejected);
  return chain;
}

let warnSpy: jest.SpyInstance;

beforeEach(() => {
  jest.clearAllMocks();
  warnSpy = jest.spyOn(console, "warn").mockImplementation(() => undefined);
  (globalThis as Record<string, unknown>).__DEV__ = true;
});

afterEach(() => {
  warnSpy.mockRestore();
});

// ── fetchUserPlans ───────────────────────────────────────────────────

describe("fetchUserPlans", () => {
  it("returns all plans for the user ordered by creation date", async () => {
    const plans = [
      { id: "p1", title: "Birthday" },
      { id: "p2", title: "Anniversary" },
    ];
    getCurrentUser.mockResolvedValue({ id: "u1" });
    const chain = simpleChain({ data: plans, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await fetchUserPlans();

    expect(mockFrom).toHaveBeenCalledWith("plans");
    expect(chain.eq).toHaveBeenCalledWith("user_id", "u1");
    expect(result).toEqual(plans);
  });

  it("throws when user is not authenticated", async () => {
    getCurrentUser.mockRejectedValue(new Error("Not authenticated"));

    await expect(fetchUserPlans()).rejects.toThrow("Not authenticated");
  });

  it("throws when database query fails", async () => {
    getCurrentUser.mockResolvedValue({ id: "u1" });
    const chain = simpleChain({
      data: null,
      error: { message: "DB error" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(fetchUserPlans()).rejects.toEqual(
      expect.objectContaining({ message: "DB error" }),
    );
  });
});

// ── fetchPlanById ────────────────────────────────────────────────────

describe("fetchPlanById", () => {
  it("returns a plan with nested scenario and checklist", async () => {
    const plan = {
      id: "p1",
      title: "Birthday",
      scenario: { id: "s1", category: { slug: "birthday" } },
      checklist: [{ id: "c1", title: "Buy cake" }],
    };
    const chain = simpleChain({ data: plan, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await fetchPlanById("p1");

    expect(mockFrom).toHaveBeenCalledWith("plans");
    expect(chain.eq).toHaveBeenCalledWith("id", "p1");
    expect(result).toEqual(plan);
  });

  it("throws when plan not found", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "No rows", code: "PGRST116" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(fetchPlanById("nonexistent")).rejects.toEqual(
      expect.objectContaining({ code: "PGRST116" }),
    );
  });
});

// ── updatePlan ───────────────────────────────────────────────────────

describe("updatePlan", () => {
  it("updates plan fields and returns updated record", async () => {
    const updated = { id: "p1", title: "New Title" };
    const chain = simpleChain({ data: updated, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await updatePlan("p1", { title: "New Title" });

    expect(chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        title: "New Title",
        updated_at: expect.any(String),
      }),
    );
    expect(result).toEqual(updated);
  });

  it("throws when update fails", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "Not found" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(updatePlan("bad", { title: "X" })).rejects.toEqual(
      expect.objectContaining({ message: "Not found" }),
    );
  });
});

// ── deletePlan ───────────────────────────────────────────────────────

describe("deletePlan", () => {
  it("deletes plan by ID", async () => {
    const chain = simpleChain({ data: null, error: null });
    // Make delete().eq() resolve directly
    (chain as Record<string, unknown>).then = (
      onFulfilled: (v: unknown) => void,
      onRejected?: (e: unknown) => void,
    ) =>
      Promise.resolve({ data: null, error: null }).then(
        onFulfilled,
        onRejected,
      );
    mockFrom.mockReturnValue(chain);

    await expect(deletePlan("p1")).resolves.toBeUndefined();
    expect(mockFrom).toHaveBeenCalledWith("plans");
    expect(chain.delete).toHaveBeenCalled();
    expect(chain.eq).toHaveBeenCalledWith("id", "p1");
  });
});

// ── toggleChecklistItem ──────────────────────────────────────────────

describe("toggleChecklistItem", () => {
  it("updates is_completed and returns the item", async () => {
    const item = { id: "c1", is_completed: true };
    const chain = simpleChain({ data: item, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await toggleChecklistItem("c1", true);

    expect(mockFrom).toHaveBeenCalledWith("plan_checklist_items");
    expect(chain.update).toHaveBeenCalledWith({ is_completed: true });
    expect(result).toEqual(item);
  });

  it("throws on error", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "RLS violation" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(toggleChecklistItem("c1", false)).rejects.toEqual(
      expect.objectContaining({ message: "RLS violation" }),
    );
  });
});

// ── addChecklistItem ─────────────────────────────────────────────────

describe("addChecklistItem", () => {
  it("adds item with next sort_order", async () => {
    const newItem = { id: "c2", title: "New task", sort_order: 3 };

    // First call: checklists select (get max sort_order)
    const selectChain = simpleChain({
      data: [{ sort_order: 2 }],
      error: null,
    });
    // Second call: checklists insert
    const insertChain = simpleChain({ data: newItem, error: null });

    let callCount = 0;
    mockFrom.mockImplementation(() => {
      callCount++;
      return callCount === 1 ? selectChain : insertChain;
    });

    const result = await addChecklistItem("p1", { title: "New task" });

    expect(result).toEqual(newItem);
  });
});

// ── deleteChecklistItem ──────────────────────────────────────────────

describe("deleteChecklistItem", () => {
  it("deletes checklist item by ID", async () => {
    const chain = simpleChain({ data: null, error: null });
    mockFrom.mockReturnValue(chain);

    await expect(deleteChecklistItem("c1")).resolves.toBeUndefined();
    expect(chain.delete).toHaveBeenCalled();
    expect(chain.eq).toHaveBeenCalledWith("id", "c1");
  });
});

// ── completePlan ─────────────────────────────────────────────────────

describe("completePlan", () => {
  it("marks plan as completed with rating and photos", async () => {
    const completed = { id: "p1", status: "completed" };
    const chain = simpleChain({ data: completed, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await completePlan("p1", {
      rating: 5,
      notes: "Great!",
      photos: ["photo1.jpg"],
      reactionType: "happy",
      memoryEntry: "Best day ever",
      shareToGallery: true,
    });

    expect(chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        status: "completed",
        completion_rating: 5,
        completion_notes: "Great!",
        completion_photos: ["photo1.jpg"],
        completed_at: expect.any(String),
      }),
    );
    expect(result).toEqual(completed);
  });

  it("handles minimal completion data", async () => {
    const completed = { id: "p1", status: "completed" };
    const chain = simpleChain({ data: completed, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await completePlan("p1", {});

    expect(chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        status: "completed",
        completed_at: expect.any(String),
      }),
    );
    expect(result).toEqual(completed);
  });

  it("throws when completion fails", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "DB error" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(completePlan("p1", { rating: 5 })).rejects.toEqual(
      expect.objectContaining({ message: "DB error" }),
    );
  });
});
