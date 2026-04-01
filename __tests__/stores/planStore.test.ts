import AsyncStorage from "@react-native-async-storage/async-storage";
import { usePlanStore } from "../../src/stores/planStore";
import * as planService from "../../src/services/plans";
import type { Plan } from "../../src/types/database";

// Mock the plans service so tests never hit Supabase
jest.mock("../../src/services/plans");
// Mock gamification and settings stores (called in completePlan)
jest.mock("../../src/stores/gamificationStore", () => ({
  useGamificationStore: {
    getState: jest.fn(() => ({
      incrementStat: jest.fn(),
      addXp: jest.fn(),
      checkAndAwardBadge: jest.fn(),
      syncToDB: jest.fn().mockResolvedValue(undefined),
      stats: { uniqueRecipients: 0, completedPlans: 0 },
    })),
  },
}));
jest.mock("../../src/stores/settingsStore", () => ({
  useSettingsStore: {
    getState: jest.fn(() => ({
      firstSurpriseCompleted: false,
      setFirstSurpriseCompleted: jest.fn(),
    })),
  },
}));
jest.mock("../../src/utils/spotlight", () => ({
  indexPlan: jest.fn().mockResolvedValue(undefined),
}));

const mockPlanService = planService as jest.Mocked<typeof planService>;

const makePlan = (overrides: Partial<Plan> = {}): Plan => ({
  id: "plan-1",
  user_id: "user-1",
  scenario_id: null,
  title: "Test Plan",
  status: "planning",
  recipient_name: "Ali",
  recipient_relation: null,
  event_date: null,
  event_time: null,
  location_text: null,
  location_lat: null,
  location_lng: null,
  budget: null,
  guest_count: null,
  notes: null,
  customizations: {},
  ai_suggestions: {},
  completion_rating: null,
  completion_notes: null,
  completion_photos: [],
  completion_data: {},
  completed_at: null,
  checklist: [],
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString(),
  ...overrides,
});

function resetStore() {
  usePlanStore.setState({
    plans: [],
    activePlan: null,
    isLoading: false,
    error: null,
  });
}

beforeEach(() => {
  (AsyncStorage as any).__resetStore();
  resetStore();
  jest.clearAllMocks();
});

// ── loadPlans ──────────────────────────────────────────────────────────

describe("planStore – loadPlans", () => {
  it("populates plans on success", async () => {
    const plans = [makePlan(), makePlan({ id: "plan-2", title: "Plan B" })];
    mockPlanService.fetchUserPlans.mockResolvedValue(plans);

    await usePlanStore.getState().loadPlans();

    expect(usePlanStore.getState().plans).toHaveLength(2);
    expect(usePlanStore.getState().isLoading).toBe(false);
    expect(usePlanStore.getState().error).toBeNull();
  });

  it("sets error when fetch fails and no cache exists", async () => {
    mockPlanService.fetchUserPlans.mockRejectedValue(
      new Error("Network error"),
    );

    await usePlanStore.getState().loadPlans();

    expect(usePlanStore.getState().error).toBe("Network error");
    expect(usePlanStore.getState().isLoading).toBe(false);
  });

  it("sets isLoading to false after fetch", async () => {
    mockPlanService.fetchUserPlans.mockResolvedValue([]);
    await usePlanStore.getState().loadPlans();
    expect(usePlanStore.getState().isLoading).toBe(false);
  });
});

// ── createPlan ────────────────────────────────────────────────────────

describe("planStore – createPlan", () => {
  it("prepends new plan to the list", async () => {
    const existing = makePlan({ id: "old" });
    usePlanStore.setState({ plans: [existing] });

    const newPlan = makePlan({ id: "new", title: "New Plan" });
    mockPlanService.createPlan.mockResolvedValue(newPlan);

    await usePlanStore.getState().createPlan({ title: "New Plan" } as any);

    const plans = usePlanStore.getState().plans;
    expect(plans[0].id).toBe("new");
    expect(plans[1].id).toBe("old");
  });

  it("throws and sets error on failure", async () => {
    mockPlanService.createPlan.mockRejectedValue(new Error("Create failed"));

    await expect(
      usePlanStore.getState().createPlan({ title: "Fail" } as any),
    ).rejects.toThrow("Create failed");

    expect(usePlanStore.getState().error).toBe("Create failed");
  });
});

// ── updatePlan ────────────────────────────────────────────────────────

describe("planStore – updatePlan", () => {
  it("updates the plan in the list", async () => {
    const plan = makePlan({ title: "Old Title" });
    usePlanStore.setState({ plans: [plan], activePlan: plan });

    const updated = { ...plan, title: "New Title" };
    mockPlanService.updatePlan.mockResolvedValue(updated);

    await usePlanStore.getState().updatePlan("plan-1", { title: "New Title" });

    expect(usePlanStore.getState().plans[0].title).toBe("New Title");
    expect(usePlanStore.getState().activePlan?.title).toBe("New Title");
  });

  it("throws on service failure", async () => {
    mockPlanService.updatePlan.mockRejectedValue(new Error("Update failed"));

    await expect(
      usePlanStore.getState().updatePlan("plan-1", { title: "X" }),
    ).rejects.toThrow("Update failed");
  });
});

// ── deletePlan ────────────────────────────────────────────────────────

describe("planStore – deletePlan", () => {
  it("removes the plan from the list", async () => {
    const plan = makePlan();
    usePlanStore.setState({ plans: [plan] });
    mockPlanService.deletePlan.mockResolvedValue(undefined as any);

    await usePlanStore.getState().deletePlan("plan-1");

    expect(usePlanStore.getState().plans).toHaveLength(0);
  });

  it("clears activePlan if the deleted plan was active", async () => {
    const plan = makePlan();
    usePlanStore.setState({ plans: [plan], activePlan: plan });
    mockPlanService.deletePlan.mockResolvedValue(undefined as any);

    await usePlanStore.getState().deletePlan("plan-1");

    expect(usePlanStore.getState().activePlan).toBeNull();
  });

  it("keeps activePlan if a different plan was deleted", async () => {
    const plan1 = makePlan({ id: "plan-1" });
    const plan2 = makePlan({ id: "plan-2" });
    usePlanStore.setState({ plans: [plan1, plan2], activePlan: plan2 });
    mockPlanService.deletePlan.mockResolvedValue(undefined as any);

    await usePlanStore.getState().deletePlan("plan-1");

    expect(usePlanStore.getState().activePlan?.id).toBe("plan-2");
    expect(usePlanStore.getState().plans).toHaveLength(1);
  });
});

// ── toggleChecklistItem ───────────────────────────────────────────────

describe("planStore – toggleChecklistItem", () => {
  const makeItem = (id: string, completed = false) => ({
    id,
    plan_id: "plan-1",
    step_id: null,
    title: "Item",
    description: null,
    is_completed: completed,
    due_date: null,
    sort_order: 0,
    completed_at: null,
    created_at: new Date().toISOString(),
  });

  it("optimistically marks item as completed", async () => {
    const plan = makePlan({ checklist: [makeItem("item-1")] });
    usePlanStore.setState({ activePlan: plan });
    mockPlanService.toggleChecklistItem.mockResolvedValue(undefined as any);

    await usePlanStore.getState().toggleChecklistItem("plan-1", "item-1", true);

    const item = usePlanStore.getState().activePlan?.checklist?.[0];
    expect(item?.is_completed).toBe(true);
    expect(item?.completed_at).toBeTruthy();
  });

  it("reverts optimistic update on failure", async () => {
    const plan = makePlan({ checklist: [makeItem("item-1")] });
    usePlanStore.setState({ activePlan: plan });
    mockPlanService.toggleChecklistItem.mockRejectedValue(new Error("Network"));

    await expect(
      usePlanStore.getState().toggleChecklistItem("plan-1", "item-1", true),
    ).rejects.toThrow("Network");

    const item = usePlanStore.getState().activePlan?.checklist?.[0];
    expect(item?.is_completed).toBe(false);
  });
});

// ── addChecklistItem ──────────────────────────────────────────────────

describe("planStore – addChecklistItem", () => {
  it("appends new item to the active plan checklist", async () => {
    const plan = makePlan({ checklist: [] });
    usePlanStore.setState({ activePlan: plan });

    const newItem = {
      id: "item-new",
      plan_id: "plan-1",
      step_id: null,
      title: "Buy flowers",
      description: null,
      is_completed: false,
      due_date: null,
      sort_order: 0,
      completed_at: null,
      created_at: new Date().toISOString(),
    };
    mockPlanService.addChecklistItem.mockResolvedValue(newItem as any);

    await usePlanStore
      .getState()
      .addChecklistItem("plan-1", { title: "Buy flowers" });

    expect(usePlanStore.getState().activePlan?.checklist).toHaveLength(1);
    expect(usePlanStore.getState().activePlan?.checklist?.[0].title).toBe(
      "Buy flowers",
    );
  });
});

// ── deleteChecklistItem ───────────────────────────────────────────────

describe("planStore – deleteChecklistItem", () => {
  it("removes the item from the checklist", async () => {
    const item = {
      id: "item-1",
      plan_id: "plan-1",
      step_id: null,
      title: "Task",
      description: null,
      is_completed: false,
      due_date: null,
      sort_order: 0,
      completed_at: null,
      created_at: new Date().toISOString(),
    };
    const plan = makePlan({ checklist: [item] });
    usePlanStore.setState({ activePlan: plan });
    mockPlanService.deleteChecklistItem.mockResolvedValue(undefined as any);

    await usePlanStore.getState().deleteChecklistItem("plan-1", "item-1");

    expect(usePlanStore.getState().activePlan?.checklist).toHaveLength(0);
  });
});
