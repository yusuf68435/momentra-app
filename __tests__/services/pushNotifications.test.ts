/**
 * Push Notifications Service Tests
 *
 * Tests the client-side push notification service that calls
 * the send-push edge function.
 */

import { sendPushToUsers } from "../../src/services/pushNotifications";
import { supabase } from "../../src/services/supabase";

// ── sendPushToUsers ─────────────────────────────────────────────────

describe("pushNotifications – sendPushToUsers", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns null for empty targetUserIds", async () => {
    const result = await sendPushToUsers([], "Title", "Body");
    expect(result).toBeNull();
  });

  it("calls send-push edge function with correct params", async () => {
    const mockInvoke = jest.fn().mockResolvedValue({
      data: { sent: 1, failed: 0, total: 1 },
      error: null,
    });
    (supabase.functions as unknown as { invoke: jest.Mock }).invoke =
      mockInvoke;

    const result = await sendPushToUsers(
      ["user-123"],
      "Test Title",
      "Test Body",
      { type: "test", planId: "plan-456" },
      "surprises",
    );

    expect(mockInvoke).toHaveBeenCalledWith("send-push", {
      body: {
        targetUserIds: ["user-123"],
        title: "Test Title",
        messageBody: "Test Body",
        data: { type: "test", planId: "plan-456" },
        channelId: "surprises",
      },
    });

    expect(result).toEqual({ sent: 1, failed: 0, total: 1 });
  });

  it("returns null on edge function error", async () => {
    const mockInvoke = jest.fn().mockResolvedValue({
      data: null,
      error: new Error("Network error"),
    });
    (supabase.functions as unknown as { invoke: jest.Mock }).invoke =
      mockInvoke;

    const result = await sendPushToUsers(["user-123"], "Title", "Body");
    expect(result).toBeNull();
  });

  it("returns null on thrown exception", async () => {
    const mockInvoke = jest.fn().mockRejectedValue(new Error("Crash"));
    (supabase.functions as unknown as { invoke: jest.Mock }).invoke =
      mockInvoke;

    const result = await sendPushToUsers(["user-123"], "Title", "Body");
    expect(result).toBeNull();
  });

  it("defaults channelId to surprises when not provided", async () => {
    const mockInvoke = jest.fn().mockResolvedValue({
      data: { sent: 1, failed: 0, total: 1 },
      error: null,
    });
    (supabase.functions as unknown as { invoke: jest.Mock }).invoke =
      mockInvoke;

    await sendPushToUsers(["user-123"], "Title", "Body");

    expect(mockInvoke).toHaveBeenCalledWith("send-push", {
      body: expect.objectContaining({
        channelId: "surprises",
      }),
    });
  });
});
