import { useNetworkStore } from '../../src/stores/networkStore';

function resetStore() {
  useNetworkStore.setState({
    isOnline: true,
    lastChecked: null,
  });
}

beforeEach(() => {
  resetStore();
});

describe('networkStore – initial state', () => {
  it('defaults to online (optimistic)', () => {
    expect(useNetworkStore.getState().isOnline).toBe(true);
  });

  it('starts with lastChecked as null', () => {
    expect(useNetworkStore.getState().lastChecked).toBeNull();
  });
});

describe('networkStore – setOnline', () => {
  it('sets isOnline to false', () => {
    useNetworkStore.getState().setOnline(false);
    expect(useNetworkStore.getState().isOnline).toBe(false);
  });

  it('sets isOnline back to true', () => {
    useNetworkStore.getState().setOnline(false);
    useNetworkStore.getState().setOnline(true);
    expect(useNetworkStore.getState().isOnline).toBe(true);
  });

  it('updates lastChecked to current timestamp', () => {
    const before = Date.now();
    useNetworkStore.getState().setOnline(true);
    const after = Date.now();

    const { lastChecked } = useNetworkStore.getState();
    expect(lastChecked).not.toBeNull();
    expect(lastChecked!).toBeGreaterThanOrEqual(before);
    expect(lastChecked!).toBeLessThanOrEqual(after);
  });

  it('updates lastChecked on each call', () => {
    useNetworkStore.getState().setOnline(true);
    const first = useNetworkStore.getState().lastChecked;

    // Advance time slightly
    jest.spyOn(Date, 'now').mockReturnValueOnce(Date.now() + 1000);
    useNetworkStore.getState().setOnline(false);
    const second = useNetworkStore.getState().lastChecked;

    expect(second).toBeGreaterThanOrEqual(first!);
  });

  it('reflects offline then online transitions correctly', () => {
    useNetworkStore.getState().setOnline(false);
    expect(useNetworkStore.getState().isOnline).toBe(false);

    useNetworkStore.getState().setOnline(true);
    expect(useNetworkStore.getState().isOnline).toBe(true);

    useNetworkStore.getState().setOnline(false);
    expect(useNetworkStore.getState().isOnline).toBe(false);
  });
});
