import { create } from 'zustand';

interface NetworkState {
  isOnline: boolean;
  lastChecked: number | null;
  setOnline: (value: boolean) => void;
}

export const useNetworkStore = create<NetworkState>((set) => ({
  // Optimistic default — assume online until first check
  isOnline: true,
  lastChecked: null,
  setOnline: (value) => set({ isOnline: value, lastChecked: Date.now() }),
}));
