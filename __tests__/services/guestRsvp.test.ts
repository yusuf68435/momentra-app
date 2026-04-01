import {
  inviteGuest,
  getGuests,
  updateRsvpStatus,
  removeGuest,
  getGuestStats,
  verifyRsvpToken,
} from "../../src/services/guestRsvp";
import type { Guest, RsvpStatus } from "../../src/services/guestRsvp";
import { supabase } from "../../src/services/supabase";

jest.mock("../../src/services/supabase", () => ({
  supabase: {
    from: jest.fn(),
    functions: { invoke: jest.fn() },
  },
}));

jest.mock("../../src/services/helpers", () => ({
  getCurrentUser: jest.fn().mockResolvedValue({ id: "user-123" }),
  getCurrentUserId: jest.fn().mockResolvedValue("user-123"),
}));

jest.mock("../../src/utils/crypto", () => ({
  generateSecureToken: jest.fn().mockReturnValue("secure-token-abc"),
  sanitizeInput: jest.fn((input: string) => input.trim()),
  sanitizeDisplayName: jest.fn((name: string) => name.trim()),
}));

const mockSupabase = supabase as jest.Mocked<typeof supabase>;

// ── Fixtures ──────────────────────────────────────────────────────────

function makeGuest(overrides: Partial<Guest> = {}): Guest {
  return {
    id: "guest-1",
    plan_id: "plan-abc",
    invited_by: "user-123",
    name: "Alice",
    email: "alice@example.com",
    phone: null,
    rsvp_status: "pending",
    rsvp_responded_at: null,
    dietary_notes: null,
    plus_one: false,
    notes: null,
    invite_token: "token-xyz",
    reminder_sent_at: null,
    created_at: "2026-01-01T00:00:00.000Z",
    updated_at: "2026-01-01T00:00:00.000Z",
    ...overrides,
  };
}

beforeEach(() => {
  jest.clearAllMocks();
});

// ── inviteGuest ───────────────────────────────────────────────────────

describe("inviteGuest", () => {
  it("inserts a guest row and returns the created record", async () => {
    const newGuest = makeGuest({ invite_token: "secure-token-abc" });

    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: newGuest, error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const insertMock = jest.fn().mockReturnValue({ select: selectMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ insert: insertMock });

    const result = await inviteGuest("plan-abc", {
      name: "Alice",
      email: "alice@example.com",
    });

    expect(result).toEqual(newGuest);
    expect(mockSupabase.from).toHaveBeenCalledWith("guest_rsvp");
    expect(insertMock).toHaveBeenCalled();
  });

  it("sets rsvp_status to pending and uses the generated invite_token", async () => {
    const newGuest = makeGuest();
    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: newGuest, error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const insertMock = jest.fn().mockReturnValue({ select: selectMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ insert: insertMock });

    await inviteGuest("plan-abc", { name: "Alice" });

    const insertedPayload = insertMock.mock.calls[0][0];
    expect(insertedPayload.rsvp_status).toBe("pending");
    expect(insertedPayload.invite_token).toBe("secure-token-abc");
  });

  it("lowercases and trims the email before inserting", async () => {
    const newGuest = makeGuest({ email: "alice@example.com" });
    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: newGuest, error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const insertMock = jest.fn().mockReturnValue({ select: selectMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ insert: insertMock });

    await inviteGuest("plan-abc", {
      name: "Alice",
      email: "  Alice@EXAMPLE.COM  ",
    });

    const insertedPayload = insertMock.mock.calls[0][0];
    expect(insertedPayload.email).toBe("alice@example.com");
  });

  it("defaults plus_one to false when not provided", async () => {
    const newGuest = makeGuest();
    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: newGuest, error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const insertMock = jest.fn().mockReturnValue({ select: selectMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ insert: insertMock });

    await inviteGuest("plan-abc", { name: "Alice" });

    const insertedPayload = insertMock.mock.calls[0][0];
    expect(insertedPayload.plus_one).toBe(false);
  });

  it("throws when supabase returns an error", async () => {
    const singleMock = jest.fn().mockResolvedValue({
      data: null,
      error: { message: "duplicate key" },
    });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const insertMock = jest.fn().mockReturnValue({ select: selectMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ insert: insertMock });

    await expect(inviteGuest("plan-abc", { name: "Alice" })).rejects.toEqual({
      message: "duplicate key",
    });
  });

  it("sets email and phone to null when not provided", async () => {
    const newGuest = makeGuest({ email: null, phone: null });
    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: newGuest, error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const insertMock = jest.fn().mockReturnValue({ select: selectMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ insert: insertMock });

    await inviteGuest("plan-abc", { name: "Alice" });

    const insertedPayload = insertMock.mock.calls[0][0];
    expect(insertedPayload.email).toBeNull();
    expect(insertedPayload.phone).toBeNull();
  });
});

// ── getGuests ─────────────────────────────────────────────────────────

describe("getGuests", () => {
  it("returns guests ordered by name for a given plan", async () => {
    const guests = [
      makeGuest({ name: "Alice" }),
      makeGuest({ id: "guest-2", name: "Bob" }),
    ];

    const orderMock = jest
      .fn()
      .mockResolvedValue({ data: guests, error: null });
    const eqMock = jest.fn().mockReturnValue({ order: orderMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    const result = await getGuests("plan-abc");

    expect(result).toEqual(guests);
    expect(mockSupabase.from).toHaveBeenCalledWith("guest_rsvp");
    expect(eqMock).toHaveBeenCalledWith("plan_id", "plan-abc");
    expect(orderMock).toHaveBeenCalledWith("name");
  });

  it("returns an empty array when there are no guests", async () => {
    const orderMock = jest.fn().mockResolvedValue({ data: null, error: null });
    const eqMock = jest.fn().mockReturnValue({ order: orderMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    const result = await getGuests("plan-empty");

    expect(result).toEqual([]);
  });

  it("throws when supabase returns an error", async () => {
    const orderMock = jest.fn().mockResolvedValue({
      data: null,
      error: { message: "permission denied" },
    });
    const eqMock = jest.fn().mockReturnValue({ order: orderMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    await expect(getGuests("plan-abc")).rejects.toEqual({
      message: "permission denied",
    });
  });
});

// ── updateRsvpStatus ──────────────────────────────────────────────────

describe("updateRsvpStatus", () => {
  it("updates the rsvp_status and sets rsvp_responded_at", async () => {
    const updatedGuest = makeGuest({
      rsvp_status: "accepted",
      rsvp_responded_at: expect.any(String) as unknown as string,
    });

    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: updatedGuest, error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const eqMock = jest.fn().mockReturnValue({ select: selectMock });
    const updateMock = jest.fn().mockReturnValue({ eq: eqMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ update: updateMock });

    const result = await updateRsvpStatus("guest-1", "accepted");

    expect(result).toEqual(updatedGuest);
    expect(mockSupabase.from).toHaveBeenCalledWith("guest_rsvp");

    const updatePayload = updateMock.mock.calls[0][0];
    expect(updatePayload.rsvp_status).toBe("accepted");
    expect(typeof updatePayload.rsvp_responded_at).toBe("string");
    expect(typeof updatePayload.updated_at).toBe("string");
  });

  it("passes the guest id to the eq filter", async () => {
    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: makeGuest(), error: null });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const eqMock = jest.fn().mockReturnValue({ select: selectMock });
    const updateMock = jest.fn().mockReturnValue({ eq: eqMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ update: updateMock });

    await updateRsvpStatus("guest-99", "declined");

    expect(eqMock).toHaveBeenCalledWith("id", "guest-99");
  });

  it("handles all valid rsvp statuses", async () => {
    const statuses: RsvpStatus[] = ["pending", "accepted", "declined", "maybe"];

    for (const status of statuses) {
      jest.clearAllMocks();

      const singleMock = jest.fn().mockResolvedValue({
        data: makeGuest({ rsvp_status: status }),
        error: null,
      });
      const selectMock = jest.fn().mockReturnValue({ single: singleMock });
      const eqMock = jest.fn().mockReturnValue({ select: selectMock });
      const updateMock = jest.fn().mockReturnValue({ eq: eqMock });

      (mockSupabase.from as jest.Mock).mockReturnValue({ update: updateMock });

      const result = await updateRsvpStatus("guest-1", status);
      expect(result.rsvp_status).toBe(status);
    }
  });

  it("throws when supabase returns an error", async () => {
    const singleMock = jest
      .fn()
      .mockResolvedValue({ data: null, error: { message: "not found" } });
    const selectMock = jest.fn().mockReturnValue({ single: singleMock });
    const eqMock = jest.fn().mockReturnValue({ select: selectMock });
    const updateMock = jest.fn().mockReturnValue({ eq: eqMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ update: updateMock });

    await expect(updateRsvpStatus("guest-999", "accepted")).rejects.toEqual({
      message: "not found",
    });
  });
});

// ── removeGuest ───────────────────────────────────────────────────────

describe("removeGuest", () => {
  it("calls delete with the correct guest id", async () => {
    const eq2Mock = jest.fn().mockResolvedValue({ error: null });
    const eq1Mock = jest.fn().mockReturnValue({ eq: eq2Mock });
    const deleteMock = jest.fn().mockReturnValue({ eq: eq1Mock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ delete: deleteMock });

    await removeGuest("guest-1");

    expect(mockSupabase.from).toHaveBeenCalledWith("guest_rsvp");
    expect(deleteMock).toHaveBeenCalled();
    expect(eq1Mock).toHaveBeenCalledWith("id", "guest-1");
    expect(eq2Mock).toHaveBeenCalledWith("invited_by", "user-123");
  });

  it("resolves without a return value on success", async () => {
    const eq2Mock = jest.fn().mockResolvedValue({ error: null });
    const eq1Mock = jest.fn().mockReturnValue({ eq: eq2Mock });
    const deleteMock = jest.fn().mockReturnValue({ eq: eq1Mock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ delete: deleteMock });

    await expect(removeGuest("guest-1")).resolves.toBeUndefined();
  });

  it("throws when supabase returns an error", async () => {
    const eq2Mock = jest
      .fn()
      .mockResolvedValue({ error: { message: "RLS violation" } });
    const eq1Mock = jest.fn().mockReturnValue({ eq: eq2Mock });
    const deleteMock = jest.fn().mockReturnValue({ eq: eq1Mock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ delete: deleteMock });

    await expect(removeGuest("guest-1")).rejects.toEqual({
      message: "RLS violation",
    });
  });
});

// ── getGuestStats ─────────────────────────────────────────────────────

describe("getGuestStats", () => {
  it("returns zeroed stats for an empty guest list", () => {
    const stats = getGuestStats([]);

    expect(stats).toEqual({
      total: 0,
      accepted: 0,
      declined: 0,
      maybe: 0,
      pending: 0,
      plus_ones: 0,
    });
  });

  it("counts each rsvp status correctly", () => {
    const guests: Guest[] = [
      makeGuest({ id: "1", rsvp_status: "accepted" }),
      makeGuest({ id: "2", rsvp_status: "accepted" }),
      makeGuest({ id: "3", rsvp_status: "declined" }),
      makeGuest({ id: "4", rsvp_status: "maybe" }),
      makeGuest({ id: "5", rsvp_status: "pending" }),
      makeGuest({ id: "6", rsvp_status: "pending" }),
    ];

    const stats = getGuestStats(guests);

    expect(stats.total).toBe(6);
    expect(stats.accepted).toBe(2);
    expect(stats.declined).toBe(1);
    expect(stats.maybe).toBe(1);
    expect(stats.pending).toBe(2);
  });

  it("counts plus_ones correctly", () => {
    const guests: Guest[] = [
      makeGuest({ id: "1", plus_one: true }),
      makeGuest({ id: "2", plus_one: true }),
      makeGuest({ id: "3", plus_one: false }),
    ];

    const stats = getGuestStats(guests);

    expect(stats.plus_ones).toBe(2);
    expect(stats.total).toBe(3);
  });

  it("returns correct total count", () => {
    const guests = Array.from({ length: 10 }, (_, i) =>
      makeGuest({ id: `guest-${i}` }),
    );

    const stats = getGuestStats(guests);

    expect(stats.total).toBe(10);
  });

  it("handles all accepted guests", () => {
    const guests: Guest[] = [
      makeGuest({ id: "1", rsvp_status: "accepted" }),
      makeGuest({ id: "2", rsvp_status: "accepted" }),
    ];

    const stats = getGuestStats(guests);

    expect(stats.accepted).toBe(2);
    expect(stats.declined).toBe(0);
    expect(stats.maybe).toBe(0);
    expect(stats.pending).toBe(0);
  });
});

// ── verifyRsvpToken ───────────────────────────────────────────────────

describe("verifyRsvpToken", () => {
  it("returns guest data when the token is valid", async () => {
    const guest = makeGuest({ invite_token: "valid-token" });

    const maybeSingleMock = jest
      .fn()
      .mockResolvedValue({ data: guest, error: null });
    const eqTokenMock = jest
      .fn()
      .mockReturnValue({ maybeSingle: maybeSingleMock });
    const eqPlanMock = jest.fn().mockReturnValue({ eq: eqTokenMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqPlanMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    const result = await verifyRsvpToken("plan-abc", "valid-token");

    expect(result).toEqual(guest);
    expect(mockSupabase.from).toHaveBeenCalledWith("guest_rsvp");
    expect(eqPlanMock).toHaveBeenCalledWith("plan_id", "plan-abc");
    expect(eqTokenMock).toHaveBeenCalledWith("invite_token", "valid-token");
  });

  it("returns null when the token does not match any guest", async () => {
    const maybeSingleMock = jest
      .fn()
      .mockResolvedValue({ data: null, error: null });
    const eqTokenMock = jest
      .fn()
      .mockReturnValue({ maybeSingle: maybeSingleMock });
    const eqPlanMock = jest.fn().mockReturnValue({ eq: eqTokenMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqPlanMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    const result = await verifyRsvpToken("plan-abc", "wrong-token");

    expect(result).toBeNull();
  });

  it("returns null when supabase returns a database error", async () => {
    const maybeSingleMock = jest.fn().mockResolvedValue({
      data: null,
      error: { message: "DB error" },
    });
    const eqTokenMock = jest
      .fn()
      .mockReturnValue({ maybeSingle: maybeSingleMock });
    const eqPlanMock = jest.fn().mockReturnValue({ eq: eqTokenMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqPlanMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    const result = await verifyRsvpToken("plan-abc", "any-token");

    expect(result).toBeNull();
  });

  it("queries with both plan_id and invite_token filters", async () => {
    const maybeSingleMock = jest
      .fn()
      .mockResolvedValue({ data: null, error: null });
    const eqTokenMock = jest
      .fn()
      .mockReturnValue({ maybeSingle: maybeSingleMock });
    const eqPlanMock = jest.fn().mockReturnValue({ eq: eqTokenMock });
    const selectMock = jest.fn().mockReturnValue({ eq: eqPlanMock });

    (mockSupabase.from as jest.Mock).mockReturnValue({ select: selectMock });

    await verifyRsvpToken("plan-xyz", "token-123");

    expect(selectMock).toHaveBeenCalledWith("*");
    expect(eqPlanMock).toHaveBeenCalledWith("plan_id", "plan-xyz");
    expect(eqTokenMock).toHaveBeenCalledWith("invite_token", "token-123");
  });
});
