import { create } from "zustand";
import * as giftApi from "../services/gifts";

// ── Types ────────────────────────────────────────────────────────────

export type Gift = giftApi.GiftSuggestion;
export type RecipientInfo = giftApi.RecipientInfo;

export interface SaveGiftData {
  name: string;
  description?: string;
  price_range?: string;
  purchase_url?: string;
  image_url?: string;
  category?: giftApi.GiftCategory;
  notes?: string;
}

// ── Store ────────────────────────────────────────────────────────────

interface GiftState {
  gifts: Record<string, Gift[]>;
  suggestions: giftApi.AiGiftSuggestion[];
  isLoading: boolean;
  error: string | null;

  // Actions
  fetchGifts: (planId: string) => Promise<void>;
  fetchSuggestions: (recipientInfo: RecipientInfo) => Promise<void>;
  saveGift: (planId: string, gift: SaveGiftData) => Promise<Gift>;
  markPurchased: (id: string) => Promise<void>;
  removeGift: (id: string) => Promise<void>;
}

export const useGiftStore = create<GiftState>((set, get) => ({
  gifts: {},
  suggestions: [],
  isLoading: false,
  error: null,

  fetchGifts: async (planId) => {
    set({ isLoading: true, error: null });
    try {
      const giftList = await giftApi.getGiftsByPlan(planId);
      set((state) => ({
        gifts: { ...state.gifts, [planId]: giftList },
      }));
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to fetch gifts";
      if (__DEV__) {
        console.error("Failed to fetch gifts:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  fetchSuggestions: async (recipientInfo) => {
    set({ isLoading: true, error: null });
    try {
      const suggestions = await giftApi.getGiftSuggestions(recipientInfo);
      set({ suggestions });
    } catch (error) {
      const message =
        error instanceof Error
          ? error.message
          : "Failed to fetch gift suggestions";
      if (__DEV__) {
        console.error("Failed to fetch gift suggestions:", error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  saveGift: async (planId, giftData) => {
    set({ isLoading: true, error: null });
    try {
      const gift = await giftApi.saveGiftIdea(planId, giftData);
      set((state) => ({
        gifts: {
          ...state.gifts,
          [planId]: [...(state.gifts[planId] ?? []), gift],
        },
      }));
      return gift;
    } catch (error) {
      const message =
        error instanceof Error ? error.message : "Failed to save gift";
      if (__DEV__) {
        console.error("Failed to save gift:", error);
      }
      set({ error: message });
      throw error;
    } finally {
      set({ isLoading: false });
    }
  },

  markPurchased: async (id) => {
    // Find which plan this gift belongs to
    const { gifts } = get();
    let targetPlanId: string | null = null;
    let currentGift: Gift | null = null;

    for (const [planId, giftList] of Object.entries(gifts)) {
      const found = giftList.find((g) => g.id === id);
      if (found) {
        targetPlanId = planId;
        currentGift = found;
        break;
      }
    }

    if (!targetPlanId || !currentGift) return;

    const newPurchased = !currentGift.is_purchased;

    // Optimistic update
    set((state) => ({
      gifts: {
        ...state.gifts,
        [targetPlanId!]: (state.gifts[targetPlanId!] ?? []).map((g) =>
          g.id === id
            ? {
                ...g,
                is_purchased: newPurchased,
                purchased_at: newPurchased ? new Date().toISOString() : null,
              }
            : g,
        ),
      },
    }));

    try {
      await giftApi.markGiftPurchased(id, newPurchased);
    } catch (error) {
      // Revert on failure
      set((state) => ({
        gifts: {
          ...state.gifts,
          [targetPlanId!]: (state.gifts[targetPlanId!] ?? []).map((g) =>
            g.id === id
              ? {
                  ...g,
                  is_purchased: !newPurchased,
                  purchased_at: currentGift!.purchased_at,
                }
              : g,
          ),
        },
      }));
      throw error;
    }
  },

  removeGift: async (id) => {
    const { gifts } = get();
    let targetPlanId: string | null = null;
    let previousGifts: Gift[] = [];
    for (const [planId, giftList] of Object.entries(gifts)) {
      if (giftList.some((g) => g.id === id)) {
        targetPlanId = planId;
        previousGifts = giftList;
        break;
      }
    }

    if (!targetPlanId) return;

    // Optimistic update
    set((state) => ({
      gifts: {
        ...state.gifts,
        [targetPlanId!]: (state.gifts[targetPlanId!] ?? []).filter(
          (g) => g.id !== id,
        ),
      },
    }));

    try {
      await giftApi.removeGift(id);
    } catch (error) {
      // Revert on failure
      set((state) => ({
        gifts: {
          ...state.gifts,
          [targetPlanId!]: previousGifts,
        },
      }));
      throw error;
    }
  },
}));
