import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { Platform } from "react-native";
import type { Plan, CompletionData } from "../types/database";
import * as planService from "../services/plans";
import * as communityService from "../services/community";
import type { StoryCategory } from "../services/community";
import { useGamificationStore } from "./gamificationStore";
import { useSettingsStore } from "./settingsStore";
import {
  cacheGet,
  cacheSet,
  cacheDelete,
  cacheGetStale,
  ACTIVE_PLAN_TTL,
} from "../utils/cache";
import { useNetworkStore } from "./networkStore";
import { indexPlan } from "../utils/spotlight";
import { trackEvent, AnalyticsEvents } from "../services/analytics";
import {
  scheduleCountdownReminders,
  cancelPlanNotifications,
  rescheduleAllReminders,
} from "../services/notificationScheduler";

let loadPlansRequestId = 0;

function mapPlanCategory(name: string): StoryCategory {
  const l = name.toLowerCase();
  if (l.includes("birthday") || l.includes("doğum")) return "birthday";
  if (l.includes("anniversary") || l.includes("yıldönüm")) return "anniversary";
  if (l.includes("proposal") || l.includes("evlilik") || l.includes("propose"))
    return "proposal";
  if (l.includes("graduation") || l.includes("mezun")) return "graduation";
  if (l.includes("baby") || l.includes("bebek")) return "baby_shower";
  if (l.includes("holiday") || l.includes("tatil") || l.includes("bayram"))
    return "holiday";
  if (l.includes("just") || l.includes("sürpriz")) return "just_because";
  return "other";
}
let loadPlanByIdRequestId = 0;

interface PlanState {
  plans: Plan[];
  activePlan: Plan | null;
  isLoading: boolean;
  error: string | null;
  // Async actions
  loadPlans: () => Promise<void>;
  loadPlanById: (id: string) => Promise<Plan>;
  createPlan: (
    plan: Parameters<typeof planService.createPlan>[0],
  ) => Promise<Plan>;
  updatePlan: (
    id: string,
    updates: Parameters<typeof planService.updatePlan>[1],
  ) => Promise<void>;
  deletePlan: (id: string) => Promise<void>;
  toggleChecklistItem: (
    planId: string,
    itemId: string,
    isCompleted: boolean,
  ) => Promise<void>;
  addChecklistItem: (
    planId: string,
    item: { title: string; description?: string; due_date?: string },
  ) => Promise<void>;
  deleteChecklistItem: (planId: string, itemId: string) => Promise<void>;
  completePlan: (id: string, data: CompletionData) => Promise<void>;
}

export const usePlanStore = create<PlanState>()(
  persist(
    (set, get) => ({
      plans: [],
      activePlan: null,
      isLoading: false,
      error: null,

      loadPlans: async () => {
        const currentRequestId = ++loadPlansRequestId;
        set({ isLoading: true, error: null });
        const isOnline = useNetworkStore.getState().isOnline;
        try {
          // Show cached data immediately while fetching
          const cached = await cacheGet<Plan[]>("plans:user");
          if (cached && currentRequestId === loadPlansRequestId) {
            set({ plans: cached });
            if (!isOnline) return; // offline — cached data is good enough
          }

          if (!isOnline) {
            // No fresh cache and offline — try stale
            const stale = await cacheGetStale<Plan[]>("plans:user");
            if (stale && currentRequestId === loadPlansRequestId) {
              set({ plans: stale });
            }
            return;
          }

          const plans = await planService.fetchUserPlans();
          // Only update if this is still the latest request
          if (currentRequestId === loadPlansRequestId) {
            set({ plans });
            await cacheSet("plans:user", plans, ACTIVE_PLAN_TTL);
          }
        } catch (error) {
          if (currentRequestId !== loadPlansRequestId) return; // Stale request, ignore
          // Fallback to stale cache on failure
          const stale = await cacheGetStale<Plan[]>("plans:user");
          if (stale) {
            set({ plans: stale });
          } else {
            const message =
              error instanceof Error ? error.message : "Failed to load plans";
            set({ error: message });
          }
        } finally {
          if (currentRequestId === loadPlansRequestId) {
            set({ isLoading: false });
          }
        }
      },

      loadPlanById: async (id: string) => {
        const currentRequestId = ++loadPlanByIdRequestId;
        set({ isLoading: true });
        const isOnline = useNetworkStore.getState().isOnline;
        try {
          // Show cached plan immediately
          const cached = await cacheGet<Plan>(`plan:${id}`);
          if (cached && currentRequestId === loadPlanByIdRequestId) {
            set({ activePlan: cached });
            if (!isOnline) return cached; // offline — cached data is good enough
          }

          if (!isOnline) {
            // No fresh cache and offline — try stale
            const stale = await cacheGetStale<Plan>(`plan:${id}`);
            if (stale && currentRequestId === loadPlanByIdRequestId) {
              set({ activePlan: stale });
              return stale;
            }
            throw new Error("offline");
          }

          const plan = await planService.fetchPlanById(id);
          // Only update if this is still the latest request
          if (currentRequestId === loadPlanByIdRequestId) {
            set({ activePlan: plan });
            await cacheSet(`plan:${id}`, plan, ACTIVE_PLAN_TTL);
          }
          return plan;
        } catch (error) {
          if (currentRequestId !== loadPlanByIdRequestId) throw error; // Stale request
          const stale = await cacheGetStale<Plan>(`plan:${id}`);
          if (stale) {
            set({ activePlan: stale });
            return stale;
          }
          throw error;
        } finally {
          if (currentRequestId === loadPlanByIdRequestId) {
            set({ isLoading: false });
          }
        }
      },

      createPlan: async (planInput) => {
        set({ isLoading: true, error: null });
        try {
          const plan = await planService.createPlan(planInput);
          set((state) => ({ plans: [plan, ...state.plans] }));
          if (Platform.OS === "ios") {
            indexPlan(plan);
          }
          cacheDelete("plans:user").catch(() => {});
          trackEvent(AnalyticsEvents.PLAN_CREATED, {
            category: plan.scenario_id ?? "custom",
          });
          // Schedule countdown reminders if the plan has an event date
          if (plan.event_date) {
            scheduleCountdownReminders(
              plan.id,
              new Date(plan.event_date),
              plan.title,
            ).catch(() => {});
          }
          return plan;
        } catch (error) {
          const message =
            error instanceof Error ? error.message : "Failed to create plan";
          if (__DEV__) {
            console.error("Failed to create plan:", error);
          }
          set({ error: message });
          throw error;
        } finally {
          set({ isLoading: false });
        }
      },

      updatePlan: async (id, updates) => {
        try {
          const plan = await planService.updatePlan(id, updates);
          set((state) => ({
            plans: state.plans.map((p) =>
              p.id === id ? { ...p, ...plan } : p,
            ),
            activePlan:
              state.activePlan?.id === id
                ? { ...state.activePlan, ...plan }
                : state.activePlan,
          }));
          if (Platform.OS === "ios") {
            indexPlan(plan);
          }
          cacheDelete("plans:user").catch(() => {});
          cacheDelete(`plan:${id}`).catch(() => {});
          // If event date changed, reschedule countdown reminders
          if (updates.event_date !== undefined && plan.event_date) {
            rescheduleAllReminders(
              id,
              new Date(plan.event_date),
              plan.title,
            ).catch(() => {});
          }
        } catch (error) {
          if (__DEV__) {
            console.error("Failed to update plan:", error);
          }
          throw error;
        }
      },

      deletePlan: async (id) => {
        const prevState = get();
        // Optimistic
        set((state) => ({
          plans: state.plans.filter((p) => p.id !== id),
          activePlan: state.activePlan?.id === id ? null : state.activePlan,
        }));
        try {
          await planService.deletePlan(id);
          cacheDelete("plans:user").catch(() => {});
          cacheDelete(`plan:${id}`).catch(() => {});
          cancelPlanNotifications(id).catch(() => {});
        } catch (error) {
          // Rollback
          set({ plans: prevState.plans, activePlan: prevState.activePlan });
          throw error;
        }
      },

      toggleChecklistItem: async (planId, itemId, isCompleted) => {
        // Optimistic update
        set((state) => ({
          activePlan:
            state.activePlan?.id === planId && state.activePlan.checklist
              ? {
                  ...state.activePlan,
                  checklist: state.activePlan.checklist.map((item) =>
                    item.id === itemId
                      ? {
                          ...item,
                          is_completed: isCompleted,
                          completed_at: isCompleted
                            ? new Date().toISOString()
                            : null,
                        }
                      : item,
                  ),
                }
              : state.activePlan,
        }));

        try {
          await planService.toggleChecklistItem(itemId, isCompleted);
        } catch (error) {
          // Revert on failure
          set((state) => ({
            activePlan:
              state.activePlan?.id === planId && state.activePlan.checklist
                ? {
                    ...state.activePlan,
                    checklist: state.activePlan.checklist.map((item) =>
                      item.id === itemId
                        ? {
                            ...item,
                            is_completed: !isCompleted,
                            completed_at: null,
                          }
                        : item,
                    ),
                  }
                : state.activePlan,
          }));
          throw error;
        }
      },

      addChecklistItem: async (planId, item) => {
        try {
          const newItem = await planService.addChecklistItem(planId, item);
          set((state) => ({
            activePlan:
              state.activePlan?.id === planId
                ? {
                    ...state.activePlan,
                    checklist: [...(state.activePlan.checklist ?? []), newItem],
                  }
                : state.activePlan,
          }));
        } catch (error) {
          if (__DEV__) console.warn("Failed to add checklist item:", error);
          throw error;
        }
      },

      deleteChecklistItem: async (planId, itemId) => {
        const prevPlan = get().activePlan;
        // Optimistic
        set((state) => ({
          activePlan:
            state.activePlan?.id === planId && state.activePlan.checklist
              ? {
                  ...state.activePlan,
                  checklist: state.activePlan.checklist.filter(
                    (ci) => ci.id !== itemId,
                  ),
                }
              : state.activePlan,
        }));
        try {
          await planService.deleteChecklistItem(itemId);
        } catch (error) {
          // Rollback
          set({ activePlan: prevPlan });
          throw error;
        }
      },

      completePlan: async (id, data) => {
        const plan = await planService.completePlan(id, data);

        // Update local state
        set((state) => ({
          plans: state.plans.map((p) => (p.id === id ? { ...p, ...plan } : p)),
          activePlan:
            state.activePlan?.id === id
              ? { ...state.activePlan, ...plan }
              : state.activePlan,
        }));

        // Trigger gamification updates
        const gamStore = useGamificationStore.getState();
        gamStore.incrementStat("completedPlans");
        gamStore.incrementStat("totalSurprises");
        gamStore.addXp(50, "surprise_completed");
        gamStore.checkAndAwardBadge("first-surprise");

        // Check if this recipient is unique among completed plans
        const { plans } = get();
        const completedPlans = plans.filter(
          (p) => p.status === "completed" && p.id !== id,
        );
        const existingRecipients = new Set(
          completedPlans.map((p) => p.recipient_name).filter(Boolean),
        );
        if (
          plan.recipient_name &&
          !existingRecipients.has(plan.recipient_name)
        ) {
          gamStore.incrementStat("uniqueRecipients");
          // Check milestone badges
          const newCount = gamStore.stats.uniqueRecipients;
          if (newCount >= 3) gamStore.checkAndAwardBadge("happy-3");
          if (newCount >= 10) gamStore.checkAndAwardBadge("happy-10");
        }

        // Check surprise count badges
        if (gamStore.stats.completedPlans >= 10) {
          gamStore.checkAndAwardBadge("surprise-10");
          gamStore.checkAndAwardBadge("master-planner");
        }

        // Mark first surprise completed for freemium
        const settingsStore = useSettingsStore.getState();
        if (!settingsStore.firstSurpriseCompleted) {
          settingsStore.setFirstSurpriseCompleted(true);
        }

        // Track completion
        trackEvent(AnalyticsEvents.PLAN_COMPLETED, {
          rating: String(data.rating ?? ""),
        });

        // Sync gamification to DB
        gamStore.syncToDB().catch(() => {});

        // Create community story if user chose to share
        if (data.shareToGallery) {
          const categoryRaw =
            plan.scenario?.category?.name_en ??
            plan.scenario?.category?.name_tr ??
            "";
          communityService
            .createStory({
              title: plan.title,
              content: plan.notes || `${plan.title} was a wonderful surprise!`,
              category: mapPlanCategory(categoryRaw),
              is_anonymous: false,
            })
            .catch(() => {});
        }
      },
    }),
    {
      name: "momentra-plans",
      storage: createJSONStorage(() => AsyncStorage),
      // Only persist the plan data, not loading/error state
      partialize: (state) => ({
        plans: state.plans,
        activePlan: state.activePlan,
      }),
    },
  ),
);
