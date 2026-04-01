import { create } from 'zustand';
import { persist, createJSONStorage } from 'zustand/middleware';
import AsyncStorage from '@react-native-async-storage/async-storage';
import * as favoritesService from '../services/favorites';

interface FavoriteState {
  favoriteIds: string[];
  isLoading: boolean;
  loadFavorites: () => Promise<void>;
  toggle: (scenarioId: string) => Promise<void>;
  isFavorited: (scenarioId: string) => boolean;
}

export const useFavoriteStore = create<FavoriteState>()(
  persist(
    (set, get) => ({
      favoriteIds: [],
      isLoading: false,

      loadFavorites: async () => {
        set({ isLoading: true });
        try {
          const ids = await favoritesService.fetchFavorites();
          set({ favoriteIds: ids });
        } catch (err) {
          if (__DEV__) {
            console.warn('Failed to load favorites:', err);
          }
        } finally {
          set({ isLoading: false });
        }
      },

      toggle: async (scenarioId: string) => {
        const { favoriteIds } = get();
        const isFav = favoriteIds.includes(scenarioId);

        // Optimistic update
        if (isFav) {
          set({ favoriteIds: favoriteIds.filter(id => id !== scenarioId) });
        } else {
          set({ favoriteIds: [...favoriteIds, scenarioId] });
        }

        try {
          await favoritesService.toggleFavorite(scenarioId);
        } catch (err) {
          // Rollback on error
          set({ favoriteIds });
          if (__DEV__) {
            console.warn('Failed to toggle favorite:', err);
          }
        }
      },

      isFavorited: (scenarioId: string) => {
        return get().favoriteIds.includes(scenarioId);
      },
    }),
    {
      name: 'momentra-favorites',
      storage: createJSONStorage(() => AsyncStorage),
      partialize: (state) => ({
        favoriteIds: state.favoriteIds,
      }),
    }
  )
);
