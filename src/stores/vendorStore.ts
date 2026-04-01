import { create } from 'zustand';
import * as vendorApi from '../services/vendors';

// ── Types ────────────────────────────────────────────────────────────

export type VendorType =
  | 'florist'
  | 'restaurant'
  | 'photographer'
  | 'decorator'
  | 'baker'
  | 'musician'
  | 'venue'
  | 'caterer'
  | 'event_planner'
  | 'other';

export type PriceRange = '$' | '$$' | '$$$' | '$$$$';

export interface Vendor {
  id: string;
  name: string;
  type: VendorType;
  description: string | null;
  address: string | null;
  city: string | null;
  latitude: number | null;
  longitude: number | null;
  phone: string | null;
  email: string | null;
  website: string | null;
  image_url: string | null;
  photos: string[];
  price_range: PriceRange;
  average_rating: number;
  review_count: number;
  is_featured: boolean;
  is_verified: boolean;
  opening_hours: Record<string, string> | null;
  tags: string[];
  created_at: string;
}

export interface VendorReview {
  id: string;
  vendor_id: string;
  user_id: string;
  rating: number;
  review: string | null;
  author_name: string | null;
  created_at: string;
}

export interface VendorFilters {
  type?: VendorType;
  location?: string;
  priceRange?: Vendor['price_range'];
  minRating?: number;
  isVerified?: boolean;
}

// ── Service layer ────────────────────────────────────────────────────

const vendorService = {
  searchVendors: (query: string, type?: VendorType, location?: string): Promise<Vendor[]> =>
    vendorApi.searchVendors(query, type as any, location) as Promise<Vendor[]>,
  fetchFeatured: (): Promise<Vendor[]> =>
    vendorApi.getFeaturedVendors() as Promise<Vendor[]>,
  rateVendor: (id: string, rating: number, review: string): Promise<VendorReview> =>
    vendorApi.rateVendor(id, rating, review) as Promise<VendorReview>,
  toggleFavorite: async (id: string): Promise<boolean> => {
    // Try to add; if already favorited, remove instead
    try {
      await vendorApi.saveVendorToFavorites(id);
      return true;
    } catch {
      await vendorApi.removeVendorFromFavorites(id);
      return false;
    }
  },
  fetchFavorites: (): Promise<Vendor[]> =>
    vendorApi.getFavoriteVendors() as Promise<Vendor[]>,
};

// ── Store ────────────────────────────────────────────────────────────

interface VendorState {
  vendors: Vendor[];
  featuredVendors: Vendor[];
  searchResults: Vendor[];
  favorites: Vendor[];
  isLoading: boolean;
  error: string | null;
  filters: VendorFilters;

  // Actions
  searchVendors: (query: string, type?: VendorType, location?: string) => Promise<void>;
  fetchFeatured: () => Promise<void>;
  rateVendor: (id: string, rating: number, review: string) => Promise<VendorReview>;
  toggleFavorite: (id: string) => Promise<void>;
  setFilters: (filters: VendorFilters) => void;
  clearFilters: () => void;
}

export const useVendorStore = create<VendorState>((set, get) => ({
  vendors: [],
  featuredVendors: [],
  searchResults: [],
  favorites: [],
  isLoading: false,
  error: null,
  filters: {},

  searchVendors: async (query, type, location) => {
    set({ isLoading: true, error: null });
    try {
      const results = await vendorService.searchVendors(query, type, location);
      set({ searchResults: results });
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Failed to search vendors';
      if (__DEV__) {
        console.error('Failed to search vendors:', error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  fetchFeatured: async () => {
    set({ isLoading: true, error: null });
    try {
      const featuredVendors = await vendorService.fetchFeatured();
      set({ featuredVendors });
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Failed to fetch featured vendors';
      if (__DEV__) {
        console.error('Failed to fetch featured vendors:', error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  rateVendor: async (id, rating, review) => {
    try {
      const vendorReview = await vendorService.rateVendor(id, rating, review);

      // Update vendor rating in all lists
      const updateVendorRating = (vendors: Vendor[]) =>
        vendors.map((v) =>
          v.id === id
            ? {
                ...v,
                average_rating: (v.average_rating * v.review_count + rating) / (v.review_count + 1),
                review_count: v.review_count + 1,
              }
            : v
        );

      set((state) => ({
        vendors: updateVendorRating(state.vendors),
        featuredVendors: updateVendorRating(state.featuredVendors),
        searchResults: updateVendorRating(state.searchResults),
        favorites: updateVendorRating(state.favorites),
      }));

      return vendorReview;
    } catch (error) {
      if (__DEV__) {
        console.error('Failed to rate vendor:', error);
      }
      throw error;
    }
  },

  toggleFavorite: async (id) => {
    // Optimistic update
    const isFavorite = get().favorites.some((v) => v.id === id);
    const vendor = [...get().vendors, ...get().featuredVendors, ...get().searchResults].find(
      (v) => v.id === id
    );

    if (isFavorite) {
      set((state) => ({
        favorites: state.favorites.filter((v) => v.id !== id),
      }));
    } else if (vendor) {
      set((state) => ({
        favorites: [...state.favorites, vendor],
      }));
    }

    try {
      await vendorService.toggleFavorite(id);
    } catch (error) {
      // Revert on failure
      if (isFavorite && vendor) {
        set((state) => ({
          favorites: [...state.favorites, vendor],
        }));
      } else {
        set((state) => ({
          favorites: state.favorites.filter((v) => v.id !== id),
        }));
      }
      if (__DEV__) {
        console.error('Failed to toggle favorite:', error);
      }
      throw error;
    }
  },

  setFilters: (filters) => {
    set((state) => ({
      filters: { ...state.filters, ...filters },
    }));
  },

  clearFilters: () => {
    set({ filters: {} });
  },
}));
