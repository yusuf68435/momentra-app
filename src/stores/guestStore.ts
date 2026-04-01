import { create } from 'zustand';
import * as guestApi from '../services/guestRsvp';

// ── Types ────────────────────────────────────────────────────────────

export type RsvpStatus = 'pending' | 'accepted' | 'declined' | 'maybe';

export interface Guest {
  id: string;
  plan_id: string;
  invited_by: string;
  name: string;
  email: string | null;
  phone: string | null;
  rsvp_status: RsvpStatus;
  rsvp_responded_at: string | null;
  dietary_notes: string | null;
  plus_one: boolean;
  notes: string | null;
  invite_token: string | null;
  reminder_sent_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface GuestStats {
  total: number;
  accepted: number;
  declined: number;
  maybe: number;
  pending: number;
  plusOnes: number;
}

export interface InviteGuestData {
  name: string;
  email?: string;
  phone?: string;
  plus_one?: boolean;
  dietary_notes?: string;
  notes?: string;
}

// ── Service layer ────────────────────────────────────────────────────

const guestService = {
  fetchGuests: (planId: string): Promise<Guest[]> => guestApi.getGuests(planId) as Promise<Guest[]>,
  inviteGuest: (planId: string, data: InviteGuestData): Promise<Guest> => guestApi.inviteGuest(planId, data) as Promise<Guest>,
  updateRsvp: (id: string, status: RsvpStatus): Promise<Guest> => guestApi.updateRsvpStatus(id, status) as Promise<Guest>,
  sendReminder: (guestId: string): Promise<void> => guestApi.sendReminder(guestId),
  removeGuest: (id: string): Promise<void> => guestApi.removeGuest(id),
};

// ── Helpers ──────────────────────────────────────────────────────────

function computeStats(guests: Guest[]): GuestStats {
  return {
    total: guests.length,
    accepted: guests.filter((g) => g.rsvp_status === 'accepted').length,
    declined: guests.filter((g) => g.rsvp_status === 'declined').length,
    maybe: guests.filter((g) => g.rsvp_status === 'maybe').length,
    pending: guests.filter((g) => g.rsvp_status === 'pending').length,
    plusOnes: guests.filter((g) => g.plus_one).length,
  };
}

// ── Store ────────────────────────────────────────────────────────────

interface GuestState {
  guests: Record<string, Guest[]>;
  stats: Record<string, GuestStats>;
  isLoading: boolean;
  error: string | null;

  // Actions
  fetchGuests: (planId: string) => Promise<void>;
  inviteGuest: (planId: string, data: InviteGuestData) => Promise<Guest>;
  updateRsvp: (id: string, status: RsvpStatus) => Promise<void>;
  sendReminder: (guestId: string) => Promise<void>;
  removeGuest: (id: string) => Promise<void>;
  getStats: (planId: string) => GuestStats;
}

export const useGuestStore = create<GuestState>((set, get) => ({
  guests: {},
  stats: {},
  isLoading: false,
  error: null,

  fetchGuests: async (planId) => {
    set({ isLoading: true, error: null });
    try {
      const guestList = await guestService.fetchGuests(planId);
      set((state) => ({
        guests: { ...state.guests, [planId]: guestList },
        stats: { ...state.stats, [planId]: computeStats(guestList) },
      }));
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Failed to fetch guests';
      if (__DEV__) {
        console.error('Failed to fetch guests:', error);
      }
      set({ error: message });
    } finally {
      set({ isLoading: false });
    }
  },

  inviteGuest: async (planId, data) => {
    set({ isLoading: true, error: null });
    try {
      const guest = await guestService.inviteGuest(planId, data);
      set((state) => {
        const updated = [...(state.guests[planId] ?? []), guest];
        return {
          guests: { ...state.guests, [planId]: updated },
          stats: { ...state.stats, [planId]: computeStats(updated) },
        };
      });
      return guest;
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Failed to invite guest';
      if (__DEV__) {
        console.error('Failed to invite guest:', error);
      }
      set({ error: message });
      throw error;
    } finally {
      set({ isLoading: false });
    }
  },

  updateRsvp: async (id, status) => {
    // Find which plan this guest belongs to
    const { guests } = get();
    let planId: string | null = null;
    for (const [pid, guestList] of Object.entries(guests)) {
      if (guestList.some((g) => g.id === id)) {
        planId = pid;
        break;
      }
    }

    try {
      const updatedGuest = await guestService.updateRsvp(id, status);
      set((state) => {
        if (!planId) return state;
        const updated = (state.guests[planId] ?? []).map((g) =>
          g.id === id ? { ...g, ...updatedGuest } : g
        );
        return {
          guests: { ...state.guests, [planId]: updated },
          stats: { ...state.stats, [planId]: computeStats(updated) },
        };
      });
    } catch (error) {
      if (__DEV__) {
        console.error('Failed to update RSVP:', error);
      }
      throw error;
    }
  },

  sendReminder: async (guestId) => {
    try {
      await guestService.sendReminder(guestId);
    } catch (error) {
      if (__DEV__) {
        console.error('Failed to send reminder:', error);
      }
      throw error;
    }
  },

  removeGuest: async (id) => {
    const { guests } = get();
    let planId: string | null = null;
    for (const [pid, guestList] of Object.entries(guests)) {
      if (guestList.some((g) => g.id === id)) {
        planId = pid;
        break;
      }
    }

    await guestService.removeGuest(id);
    set((state) => {
      if (!planId) return state;
      const updated = (state.guests[planId] ?? []).filter((g) => g.id !== id);
      return {
        guests: { ...state.guests, [planId]: updated },
        stats: { ...state.stats, [planId]: computeStats(updated) },
      };
    });
  },

  getStats: (planId) => {
    const { stats, guests } = get();
    if (stats[planId]) return stats[planId];
    return computeStats(guests[planId] ?? []);
  },
}));
