import {
  fetchExpenses,
  addExpense,
  updateExpense,
  deleteExpense,
  getExpenseSummary,
  type Expense,
} from "../../src/services/expenses";
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
  getCurrentUser: jest.fn().mockResolvedValue({ id: "u1" }),
  getCurrentUserId: jest.fn().mockResolvedValue("u1"),
}));

const mockFrom = supabase.from as jest.Mock;

// Chainable Supabase query mock
function simpleChain(finalResult: {
  data?: unknown;
  error?: { message: string } | null;
}) {
  const chain: Record<string, jest.Mock> = {};
  const methods = [
    "select",
    "insert",
    "update",
    "delete",
    "eq",
    "order",
    "single",
    "maybeSingle",
    "not",
    "limit",
  ];
  methods.forEach((m) => {
    chain[m] = jest.fn().mockReturnValue(chain);
  });
  chain.single = jest.fn().mockResolvedValue(finalResult);
  chain.maybeSingle = jest.fn().mockResolvedValue(finalResult);
  // Make chain thenable for array returns
  (chain as Record<string, unknown>).then = (
    onFulfilled: (v: unknown) => void,
    onRejected?: (e: unknown) => void,
  ) => Promise.resolve(finalResult).then(onFulfilled, onRejected);
  return chain;
}

/** Configure mockFrom so that "plans" queries return the access-pass result
 *  (user_id: "u1") and all other table queries return the provided chain. */
function withAccessCheck(expenseChain: ReturnType<typeof simpleChain>) {
  const accessChain = simpleChain({ data: { user_id: "u1" }, error: null });
  mockFrom.mockImplementation((table: string) => {
    if (table === "plans") return accessChain;
    return expenseChain;
  });
}

/** For update/delete: first plan_expenses call fetches plan_id,
 *  then plans access check, then the actual operation. */
function withUpdateAccessCheck(
  lookupResult: { data?: unknown; error?: { message: string } | null },
  operationChain: ReturnType<typeof simpleChain>,
) {
  const accessChain = simpleChain({ data: { user_id: "u1" }, error: null });
  const lookupChain = simpleChain(lookupResult);
  let planExpensesCount = 0;
  mockFrom.mockImplementation((table: string) => {
    if (table === "plans") return accessChain;
    if (table === "plan_expenses") {
      planExpensesCount++;
      return planExpensesCount === 1 ? lookupChain : operationChain;
    }
    return simpleChain({ data: null, error: null });
  });
}

beforeEach(() => {
  jest.clearAllMocks();
});

// ── fetchExpenses ────────────────────────────────────────────────────

describe("fetchExpenses", () => {
  it("returns expenses for a plan ordered by creation date", async () => {
    const expenses = [
      { id: "e1", name: "Cake", amount: 100 },
      { id: "e2", name: "Flowers", amount: 50 },
    ];
    const chain = simpleChain({ data: expenses, error: null });
    withAccessCheck(chain);

    const result = await fetchExpenses("plan1");

    expect(mockFrom).toHaveBeenCalledWith("plan_expenses");
    expect(chain.eq).toHaveBeenCalledWith("plan_id", "plan1");
    expect(chain.order).toHaveBeenCalledWith("created_at", {
      ascending: false,
    });
    expect(result).toEqual(expenses);
  });

  it("returns empty array when no expenses exist", async () => {
    const chain = simpleChain({ data: null, error: null });
    withAccessCheck(chain);

    const result = await fetchExpenses("plan1");
    expect(result).toEqual([]);
  });

  it("throws when database query fails", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "Connection error" },
    });
    withAccessCheck(chain);

    await expect(fetchExpenses("plan1")).rejects.toEqual(
      expect.objectContaining({ message: "Connection error" }),
    );
  });
});

// ── addExpense ───────────────────────────────────────────────────────

describe("addExpense", () => {
  it("inserts expense with user ID as paid_by", async () => {
    const newExpense = {
      id: "e1",
      name: "Cake",
      amount: 100,
      category: "food",
      is_paid: false,
    };
    const chain = simpleChain({ data: newExpense, error: null });
    withAccessCheck(chain);

    const result = await addExpense("plan1", {
      name: "Cake",
      amount: 100,
      category: "food",
    });

    expect(chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        plan_id: "plan1",
        name: "Cake",
        amount: 100,
        category: "food",
        is_paid: false,
        paid_by: "u1",
        notes: null,
      }),
    );
    expect(result).toEqual(newExpense);
  });

  it("sets is_paid to false by default", async () => {
    const chain = simpleChain({
      data: { id: "e1" },
      error: null,
    });
    withAccessCheck(chain);

    await addExpense("plan1", {
      name: "Test",
      amount: 50,
      category: "other",
    });

    expect(chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({ is_paid: false }),
    );
  });

  it("throws when not authenticated", async () => {
    const { getCurrentUser } = jest.requireMock(
      "../../src/services/helpers",
    ) as { getCurrentUser: jest.Mock };
    getCurrentUser.mockRejectedValueOnce(new Error("Not authenticated"));

    await expect(
      addExpense("plan1", { name: "Test", amount: 50, category: "gift" }),
    ).rejects.toThrow("Not authenticated");
  });

  it("throws when insert fails", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "RLS violation" },
    });
    withAccessCheck(chain);

    await expect(
      addExpense("plan1", { name: "X", amount: 10, category: "other" }),
    ).rejects.toEqual(expect.objectContaining({ message: "RLS violation" }));
  });
});

// ── updateExpense ────────────────────────────────────────────────────

describe("updateExpense", () => {
  it("updates expense fields and returns record", async () => {
    const updated = { id: "e1", name: "Updated", amount: 200 };
    const operationChain = simpleChain({ data: updated, error: null });
    withUpdateAccessCheck(
      { data: { plan_id: "plan1" }, error: null },
      operationChain,
    );

    const result = await updateExpense("e1", { name: "Updated", amount: 200 });

    expect(operationChain.update).toHaveBeenCalledWith({
      name: "Updated",
      amount: 200,
    });
    expect(operationChain.eq).toHaveBeenCalledWith("id", "e1");
    expect(result).toEqual(updated);
  });

  it("throws when expense not found", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "Not found" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(updateExpense("bad", { name: "X" })).rejects.toEqual(
      expect.objectContaining({ message: "Not found" }),
    );
  });
});

// ── deleteExpense ────────────────────────────────────────────────────

describe("deleteExpense", () => {
  it("deletes expense by ID", async () => {
    const chain = simpleChain({ data: null, error: null });
    mockFrom.mockReturnValue(chain);

    await expect(deleteExpense("e1")).resolves.toBeUndefined();
    expect(chain.delete).toHaveBeenCalled();
    expect(chain.eq).toHaveBeenCalledWith("id", "e1");
  });

  it("throws when delete fails", async () => {
    const chain = simpleChain({
      data: null,
      error: { message: "Delete failed" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(deleteExpense("e1")).rejects.toEqual(
      expect.objectContaining({ message: "Delete failed" }),
    );
  });
});

// ── getExpenseSummary (pure function) ────────────────────────────────

describe("getExpenseSummary", () => {
  const makeExpense = (overrides: Partial<Expense>): Expense => ({
    id: "e1",
    plan_id: "p1",
    name: "Test",
    amount: 0,
    category: "other",
    is_paid: false,
    paid_by: null,
    notes: null,
    created_at: "2026-01-01",
    ...overrides,
  });

  it("calculates total, paid, and unpaid amounts", () => {
    const expenses = [
      makeExpense({ id: "e1", amount: 100, is_paid: true }),
      makeExpense({ id: "e2", amount: 50, is_paid: false }),
      makeExpense({ id: "e3", amount: 75, is_paid: true }),
    ];

    const summary = getExpenseSummary(expenses);

    expect(summary.total).toBe(225);
    expect(summary.paid).toBe(175);
    expect(summary.unpaid).toBe(50);
  });

  it("groups expenses by category", () => {
    const expenses = [
      makeExpense({ id: "e1", amount: 100, category: "food" }),
      makeExpense({ id: "e2", amount: 50, category: "food" }),
      makeExpense({ id: "e3", amount: 200, category: "venue" }),
    ];

    const summary = getExpenseSummary(expenses);

    expect(summary.byCategory).toEqual({
      food: 150,
      venue: 200,
    });
  });

  it("returns zero summary for empty expense list", () => {
    const summary = getExpenseSummary([]);

    expect(summary.total).toBe(0);
    expect(summary.paid).toBe(0);
    expect(summary.unpaid).toBe(0);
    expect(summary.byCategory).toEqual({});
  });

  it("handles single expense correctly", () => {
    const expenses = [
      makeExpense({ id: "e1", amount: 42, category: "gift", is_paid: true }),
    ];

    const summary = getExpenseSummary(expenses);

    expect(summary.total).toBe(42);
    expect(summary.paid).toBe(42);
    expect(summary.unpaid).toBe(0);
    expect(summary.byCategory).toEqual({ gift: 42 });
  });
});
