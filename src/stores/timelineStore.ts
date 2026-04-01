import { create } from "zustand";
import type { Plan } from "../types/database";
import * as timelineApi from "../services/timeline";

// ── Types ────────────────────────────────────────────────────────────

export interface TimelineItem {
  id: string;
  plan_id: string;
  user_id: string;
  title: string;
  description: string | null;
  due_date: string | null;
  is_completed: boolean;
  completed_at: string | null;
  priority: "low" | "medium" | "high" | "urgent";
  category:
    | "preparation"
    | "shopping"
    | "decoration"
    | "coordination"
    | "logistics"
    | "other";
  sort_order: number;
  created_at: string;
  updated_at: string;
}

export interface UpdateTimelineData {
  title?: string;
  description?: string;
  due_date?: string;
  is_completed?: boolean;
  priority?: TimelineItem["priority"];
  category?: TimelineItem["category"];
  sort_order?: number;
}

// ── Service layer ────────────────────────────────────────────────────

const timelineService = {
  fetchTimeline: (planId: string): Promise<TimelineItem[]> =>
    timelineApi.getTimeline(planId) as Promise<TimelineItem[]>,
  generateTimeline: (plan: Plan): Promise<TimelineItem[]> =>
    timelineApi.generateTimeline(plan) as Promise<TimelineItem[]>,
  updateItem: (id: string, data: UpdateTimelineData): Promise<TimelineItem> =>
    timelineApi.updateTimelineItem(id, data) as Promise<TimelineItem>,
  toggleComplete: (id: string, isCompleted: boolean): Promise<void> =>
    timelineApi
      .updateTimelineItem(id, {
        is_completed: isCompleted,
      } as UpdateTimelineData)
      .then(() => {}),
  reorder: (items: { id: string; sort_order: number }[]): Promise<void> =>
    timelineApi.reorderTimeline(items),
  deleteItem: (id: string): Promise<void> => timelineApi.deleteTimelineItem(id),
};

// ── Store ────────────────────────────────────────────────────────────

interface AddTimelineItemInput {
  title: string;
  description?: string;
  due_date?: string;
  priority?: TimelineItem["priority"];
  category?: TimelineItem["category"];
}

interface TimelineState {
  timelines: Record<string, TimelineItem[]>;
  isLoading: boolean;
  error: string | null;

  // Actions
  fetchTimeline: (planId: string) => Promise<void>;
  generateTimeline: (plan: Plan) => Promise<TimelineItem[]>;
  addItem: (
    planId: string,
    item: AddTimelineItemInput,
  ) => Promise<TimelineItem>;
  updateItem: (id: string, data: UpdateTimelineData) => Promise<void>;
  toggleComplete: (id: string) => Promise<void>;
  reorder: (planId: string, items: TimelineItem[]) => Promise<void>;
  deleteItem: (id: string) => Promise<void>;
}

export const useTimelineStore = create<TimelineState>((set, get) => ({
  timelines: {},
  isLoading: false,
  error: null,

  fetchTimeline: async (planId) => {
    set({ isLoading: true, error: null });
    try {
      const items = await timelineService.fetchTimeline(planId);
      set((state) => ({
        timelines: { ...state.timelines, [planId]: items },
      }));
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to fetch timeline";
      if (__DEV__) {
        console.error("Failed to fetch timeline:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  generateTimeline: async (plan) => {
    set({ isLoading: true, error: null });
    try {
      const items = await timelineService.generateTimeline(plan);
      set((state) => ({
        timelines: { ...state.timelines, [plan.id]: items },
      }));
      return items;
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to generate timeline";
      if (__DEV__) {
        console.error("Failed to generate timeline:", error);
      }
      set({ error: message });
      throw error;
    } finally {
      set({ isLoading: false });
    }
  },

  addItem: async (planId, item) => {
    const newItem = await timelineApi.addTimelineItem(planId, item);
    if (!newItem) {
      throw new Error("Failed to add timeline item");
    }
    set((state) => ({
      timelines: {
        ...state.timelines,
        [planId]: [...(state.timelines[planId] ?? []), newItem],
      },
    }));
    return newItem;
  },

  updateItem: async (id, data) => {
    try {
      const updatedItem = await timelineService.updateItem(id, data);
      set((state) => {
        const newTimelines = { ...state.timelines };
        for (const [planId, items] of Object.entries(newTimelines)) {
          const index = items.findIndex((item) => item.id === id);
          if (index !== -1) {
            newTimelines[planId] = items.map((item) =>
              item.id === id ? { ...item, ...updatedItem } : item,
            );
            break;
          }
        }
        return { timelines: newTimelines };
      });
    } catch (error) {
      if (__DEV__) {
        console.error("Failed to update timeline item:", error);
      }
      throw error;
    }
  },

  toggleComplete: async (id) => {
    // Find the item and its plan
    const { timelines } = get();
    let targetPlanId: string | null = null;
    let currentItem: TimelineItem | null = null;

    for (const [planId, items] of Object.entries(timelines)) {
      const found = items.find((item) => item.id === id);
      if (found) {
        targetPlanId = planId;
        currentItem = found;
        break;
      }
    }

    if (!targetPlanId || !currentItem) return;

    const newCompleted = !currentItem.is_completed;

    // Optimistic update
    set((state) => ({
      timelines: {
        ...state.timelines,
        [targetPlanId!]: (state.timelines[targetPlanId!] ?? []).map((item) =>
          item.id === id ? { ...item, is_completed: newCompleted } : item,
        ),
      },
    }));

    try {
      await timelineService.toggleComplete(id, newCompleted);
    } catch (error) {
      // Revert on failure
      set((state) => ({
        timelines: {
          ...state.timelines,
          [targetPlanId!]: (state.timelines[targetPlanId!] ?? []).map((item) =>
            item.id === id ? { ...item, is_completed: !newCompleted } : item,
          ),
        },
      }));
      throw error;
    }
  },

  reorder: async (planId, items) => {
    // Optimistic update
    const previousItems = get().timelines[planId] ?? [];
    set((state) => ({
      timelines: { ...state.timelines, [planId]: items },
    }));

    try {
      await timelineService.reorder(
        items.map((item, index) => ({ id: item.id, sort_order: index })),
      );
    } catch (error) {
      // Revert on failure
      set((state) => ({
        timelines: { ...state.timelines, [planId]: previousItems },
      }));
      if (__DEV__) {
        console.error("Failed to reorder timeline:", error);
      }
      throw error;
    }
  },

  deleteItem: async (id) => {
    const { timelines } = get();
    let targetPlanId: string | null = null;
    for (const [planId, items] of Object.entries(timelines)) {
      if (items.some((item) => item.id === id)) {
        targetPlanId = planId;
        break;
      }
    }

    await timelineService.deleteItem(id);

    if (targetPlanId) {
      set((state) => ({
        timelines: {
          ...state.timelines,
          [targetPlanId!]: (state.timelines[targetPlanId!] ?? []).filter(
            (item) => item.id !== id,
          ),
        },
      }));
    }
  },
}));
