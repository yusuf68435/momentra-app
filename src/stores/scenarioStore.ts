import { create } from "zustand";
import type { Scenario, Category } from "../types/database";
import * as scenarioService from "../services/scenarios";
import { cacheGet, cacheSet, cacheGetStale, LONG_TTL } from "../utils/cache";
import { useNetworkStore } from "./networkStore";
import { debounce } from "../utils/rateLimiter";

interface ScenarioFilters {
  categoryId: string | null;
  budgetMin: number | null;
  budgetMax: number | null;
  peopleCount: number | null;
  indoorOutdoor: "indoor" | "outdoor" | "both" | null;
  difficulty: number | null;
  searchQuery: string;
}

interface ScenarioState {
  scenarios: Scenario[];
  categories: Category[];
  featuredScenarios: Scenario[];
  currentScenario: Scenario | null;
  filters: ScenarioFilters;
  isLoading: boolean;
  error: string | null;
  setFilters: (filters: Partial<ScenarioFilters>) => void;
  clearFilters: () => void;
  // Async actions
  loadCategories: () => Promise<void>;
  loadScenarios: () => Promise<void>;
  loadFeaturedScenarios: () => Promise<void>;
  loadScenarioById: (id: string) => Promise<Scenario>;
  loadScenariosByCategory: (slug: string) => Promise<void>;
  searchScenarios: (query: string) => Promise<void>;
}

const SEARCH_DEBOUNCE_MS = 300;

const defaultFilters: ScenarioFilters = {
  categoryId: null,
  budgetMin: null,
  budgetMax: null,
  peopleCount: null,
  indoorOutdoor: null,
  difficulty: null,
  searchQuery: "",
};

export const useScenarioStore = create<ScenarioState>((set, get) => ({
  scenarios: [],
  categories: [],
  featuredScenarios: [],
  currentScenario: null,
  filters: defaultFilters,
  isLoading: false,
  error: null,
  setFilters: (filters) =>
    set((state) => ({ filters: { ...state.filters, ...filters } })),
  clearFilters: () => set({ filters: defaultFilters }),

  loadCategories: async () => {
    const isOnline = useNetworkStore.getState().isOnline;
    try {
      // Try fresh cache first
      const cached = await cacheGet<Category[]>("categories");
      if (cached) {
        set({ categories: cached });
        if (!isOnline) return; // offline — cached data is good enough
      }

      if (!isOnline) {
        // No fresh cache and offline — try stale
        const stale = await cacheGetStale<Category[]>("categories");
        if (stale) set({ categories: stale });
        return;
      }

      const categories = await scenarioService.fetchCategories();
      set({ categories });
      await cacheSet("categories", categories, LONG_TTL);
    } catch (error) {
      // On failure, use stale cached data if available
      const stale = await cacheGetStale<Category[]>("categories");
      if (stale) {
        set({ categories: stale });
      } else if (__DEV__) {
        console.error("Failed to load categories:", error);
      }
    }
  },

  loadScenarios: async () => {
    set({ isLoading: true, error: null });
    const isOnline = useNetworkStore.getState().isOnline;
    try {
      const { filters } = get();
      const hasFilters =
        filters.categoryId ||
        filters.budgetMin ||
        filters.budgetMax ||
        filters.peopleCount ||
        filters.indoorOutdoor ||
        filters.difficulty ||
        filters.searchQuery;

      // Only cache unfiltered results
      if (!hasFilters) {
        const cached = await cacheGet<Scenario[]>("scenarios:all");
        if (cached) {
          set({ scenarios: cached });
          if (!isOnline) return; // offline — use cached
        }
      }

      if (!isOnline) {
        const stale = await cacheGetStale<Scenario[]>("scenarios:all");
        if (stale) set({ scenarios: stale });
        return;
      }

      const scenarios = await scenarioService.fetchScenarios({
        categoryId: filters.categoryId ?? undefined,
        budgetMin: filters.budgetMin ?? undefined,
        budgetMax: filters.budgetMax ?? undefined,
        peopleCount: filters.peopleCount ?? undefined,
        indoorOutdoor: filters.indoorOutdoor ?? undefined,
        difficulty: filters.difficulty ?? undefined,
        search: filters.searchQuery || undefined,
      });
      set({ scenarios });

      if (!hasFilters) {
        await cacheSet("scenarios:all", scenarios, LONG_TTL);
      }
    } catch (error) {
      // Fallback to stale cache
      const stale = await cacheGetStale<Scenario[]>("scenarios:all");
      if (stale) {
        set({ scenarios: stale });
      } else {
        const message =
          error instanceof Error ? error.message : "Failed to load scenarios";
        if (__DEV__) {
          console.error("Failed to load scenarios:", error);
        }
        set({ error: message });
      }
    } finally {
      set({ isLoading: false });
    }
  },

  loadFeaturedScenarios: async () => {
    const isOnline = useNetworkStore.getState().isOnline;
    try {
      const cached = await cacheGet<Scenario[]>("scenarios:featured");
      if (cached) {
        set({ featuredScenarios: cached });
        if (!isOnline) return;
      }

      if (!isOnline) {
        const stale = await cacheGetStale<Scenario[]>("scenarios:featured");
        if (stale) set({ featuredScenarios: stale });
        return;
      }

      const featuredScenarios = await scenarioService.fetchFeaturedScenarios();
      set({ featuredScenarios });
      await cacheSet("scenarios:featured", featuredScenarios, LONG_TTL);
    } catch (error) {
      const stale = await cacheGetStale<Scenario[]>("scenarios:featured");
      if (stale) {
        set({ featuredScenarios: stale });
      } else if (__DEV__) {
        console.error("Failed to load featured scenarios:", error);
      }
    }
  },

  loadScenarioById: async (id: string) => {
    set({ isLoading: true });
    try {
      const scenario = await scenarioService.fetchScenarioById(id);
      set({ currentScenario: scenario });
      // Track view
      scenarioService.incrementViewCount(id);
      return scenario;
    } finally {
      set({ isLoading: false });
    }
  },

  loadScenariosByCategory: async (slug: string) => {
    set({ isLoading: true });
    try {
      const scenarios = await scenarioService.fetchScenariosByCategory(slug);
      set({ scenarios });
    } catch (error) {
      if (__DEV__) {
        console.error("Failed to load scenarios by category:", error);
      }
    } finally {
      set({ isLoading: false });
    }
  },

  searchScenarios: (() => {
    const debouncedFetch = debounce(async (...args: unknown[]) => {
      const query = args[0] as string;
      try {
        const scenarios = await scenarioService.fetchScenarios({
          search: query,
        });
        useScenarioStore.setState({ scenarios, isLoading: false });
      } catch {
        useScenarioStore.setState({ isLoading: false });
      }
    }, SEARCH_DEBOUNCE_MS);

    return async (query: string) => {
      set((state) => ({
        filters: { ...state.filters, searchQuery: query },
        isLoading: true,
      }));
      debouncedFetch(query);
    };
  })(),
}));
