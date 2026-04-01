import {
  signUp,
  signIn,
  signOut,
  resetPassword,
  getCurrentSession,
  fetchProfile,
  updateProfile,
  deleteAccount,
  fetchSubscription,
} from "../../src/services/auth";
import { supabase } from "../../src/services/supabase";

// ── Mocks ────────────────────────────────────────────────────────────

jest.mock("../../src/services/supabase", () => ({
  supabase: {
    auth: {
      signUp: jest.fn(),
      signInWithPassword: jest.fn(),
      signOut: jest.fn(),
      resetPasswordForEmail: jest.fn(),
      getSession: jest.fn(),
      getUser: jest.fn(),
    },
    from: jest.fn(),
    functions: { invoke: jest.fn() },
  },
}));

jest.mock("../../src/services/helpers", () => ({
  getCurrentUser: jest.fn(),
  getCurrentUserId: jest.fn(),
}));

const mockAuth = supabase.auth as jest.Mocked<typeof supabase.auth>;
const mockFrom = supabase.from as jest.Mock;
const mockInvoke = supabase.functions.invoke as jest.Mock;

const { getCurrentUser, getCurrentUserId } = jest.requireMock(
  "../../src/services/helpers",
) as {
  getCurrentUser: jest.Mock;
  getCurrentUserId: jest.Mock;
};

// Helper to build chainable Supabase query mock
function buildQueryMock(finalResult: {
  data?: unknown;
  error?: { message: string; code?: string } | null;
}) {
  const chain: Record<string, jest.Mock> = {};
  const methods = [
    "select",
    "insert",
    "update",
    "delete",
    "eq",
    "single",
    "maybeSingle",
  ];
  methods.forEach((method) => {
    chain[method] = jest.fn().mockReturnValue(chain);
  });
  chain.single = jest.fn().mockResolvedValue(finalResult);
  chain.maybeSingle = jest.fn().mockResolvedValue(finalResult);
  return chain;
}

beforeEach(() => {
  jest.clearAllMocks();
});

// ── signUp ───────────────────────────────────────────────────────────

describe("signUp", () => {
  it("creates a new user with email, password and display_name", async () => {
    const mockData = { user: { id: "u1" }, session: { access_token: "tok" } };
    mockAuth.signUp.mockResolvedValue({ data: mockData, error: null } as never);

    const result = await signUp("test@test.com", "Pass123!", "Alice");

    expect(mockAuth.signUp).toHaveBeenCalledWith({
      email: "test@test.com",
      password: "Pass123!",
      options: { data: { display_name: "Alice" } },
    });
    expect(result).toEqual(mockData);
  });

  it("throws when supabase returns an error", async () => {
    mockAuth.signUp.mockResolvedValue({
      data: { user: null, session: null },
      error: { message: "Email already exists" },
    } as never);

    await expect(signUp("dup@test.com", "Pass123!", "Bob")).rejects.toEqual(
      expect.objectContaining({ message: "Email already exists" }),
    );
  });
});

// ── signIn ───────────────────────────────────────────────────────────

describe("signIn", () => {
  it("authenticates user and returns session data", async () => {
    const mockData = { user: { id: "u1" }, session: { access_token: "tok" } };
    mockAuth.signInWithPassword.mockResolvedValue({
      data: mockData,
      error: null,
    } as never);

    const result = await signIn("test@test.com", "Pass123!");

    expect(mockAuth.signInWithPassword).toHaveBeenCalledWith({
      email: "test@test.com",
      password: "Pass123!",
    });
    expect(result).toEqual(mockData);
  });

  it("throws when credentials are incorrect", async () => {
    mockAuth.signInWithPassword.mockResolvedValue({
      data: { user: null, session: null },
      error: { message: "Invalid login credentials" },
    } as never);

    await expect(signIn("test@test.com", "wrong")).rejects.toEqual(
      expect.objectContaining({ message: "Invalid login credentials" }),
    );
  });
});

// ── signOut ──────────────────────────────────────────────────────────

describe("signOut", () => {
  it("signs out successfully", async () => {
    mockAuth.signOut.mockResolvedValue({ error: null } as never);

    await expect(signOut()).resolves.toBeUndefined();
    expect(mockAuth.signOut).toHaveBeenCalledTimes(1);
  });

  it("throws when sign out fails", async () => {
    mockAuth.signOut.mockResolvedValue({
      error: { message: "Network error" },
    } as never);

    await expect(signOut()).rejects.toEqual(
      expect.objectContaining({ message: "Network error" }),
    );
  });
});

// ── resetPassword ────────────────────────────────────────────────────

describe("resetPassword", () => {
  it("silently succeeds to prevent email enumeration", async () => {
    mockAuth.resetPasswordForEmail.mockResolvedValue({
      data: {},
      error: null,
    } as never);

    await expect(resetPassword("any@test.com")).resolves.toBeUndefined();
    expect(mockAuth.resetPasswordForEmail).toHaveBeenCalledWith("any@test.com");
  });

  it("does not throw even if email does not exist", async () => {
    mockAuth.resetPasswordForEmail.mockResolvedValue({
      data: {},
      error: { message: "User not found" },
    } as never);

    // Should NOT throw — prevents email enumeration
    await expect(
      resetPassword("nonexistent@test.com"),
    ).resolves.toBeUndefined();
  });
});

// ── getCurrentSession ────────────────────────────────────────────────

describe("getCurrentSession", () => {
  it("returns the current session", async () => {
    const session = { access_token: "tok", user: { id: "u1" } };
    mockAuth.getSession.mockResolvedValue({
      data: { session },
      error: null,
    } as never);

    const result = await getCurrentSession();
    expect(result).toEqual(session);
  });

  it("returns null when no session exists", async () => {
    mockAuth.getSession.mockResolvedValue({
      data: { session: null },
      error: null,
    } as never);

    const result = await getCurrentSession();
    expect(result).toBeNull();
  });

  it("throws when getSession fails", async () => {
    mockAuth.getSession.mockResolvedValue({
      data: { session: null },
      error: { message: "Auth service unavailable" },
    } as never);

    await expect(getCurrentSession()).rejects.toEqual(
      expect.objectContaining({ message: "Auth service unavailable" }),
    );
  });
});

// ── fetchProfile ─────────────────────────────────────────────────────

describe("fetchProfile", () => {
  it("returns null when user is not authenticated", async () => {
    getCurrentUserId.mockResolvedValue(null);

    const result = await fetchProfile();
    expect(result).toBeNull();
    expect(mockFrom).not.toHaveBeenCalled();
  });

  it("fetches and returns user profile", async () => {
    const profile = { id: "u1", display_name: "Alice", language: "en" };
    getCurrentUserId.mockResolvedValue("u1");
    const chain = buildQueryMock({ data: profile, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await fetchProfile();

    expect(mockFrom).toHaveBeenCalledWith("profiles");
    expect(chain.select).toHaveBeenCalledWith("*");
    expect(chain.eq).toHaveBeenCalledWith("id", "u1");
    expect(result).toEqual(profile);
  });

  it("throws when profile fetch fails", async () => {
    getCurrentUserId.mockResolvedValue("u1");
    const chain = buildQueryMock({
      data: null,
      error: { message: "DB error" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(fetchProfile()).rejects.toEqual(
      expect.objectContaining({ message: "DB error" }),
    );
  });
});

// ── updateProfile ────────────────────────────────────────────────────

describe("updateProfile", () => {
  it("updates profile fields and returns updated record", async () => {
    const updated = {
      id: "u1",
      display_name: "Alice Updated",
      language: "tr",
    };
    getCurrentUser.mockResolvedValue({ id: "u1" });
    const chain = buildQueryMock({ data: updated, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await updateProfile({ display_name: "Alice Updated" });

    expect(mockFrom).toHaveBeenCalledWith("profiles");
    expect(chain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        display_name: "Alice Updated",
        updated_at: expect.any(String),
      }),
    );
    expect(chain.eq).toHaveBeenCalledWith("id", "u1");
    expect(result).toEqual(updated);
  });

  it("throws when user is not authenticated", async () => {
    getCurrentUser.mockRejectedValue(new Error("Not authenticated"));

    await expect(updateProfile({ display_name: "Fail" })).rejects.toThrow(
      "Not authenticated",
    );
  });
});

// ── deleteAccount ────────────────────────────────────────────────────

describe("deleteAccount", () => {
  it("invokes delete-account function and signs out", async () => {
    mockInvoke.mockResolvedValue({ data: { success: true }, error: null });
    mockAuth.signOut.mockResolvedValue({ error: null } as never);

    await expect(deleteAccount()).resolves.toBeUndefined();

    expect(mockInvoke).toHaveBeenCalledWith("delete-account");
    expect(mockAuth.signOut).toHaveBeenCalled();
  });

  it("throws when edge function returns error", async () => {
    mockInvoke.mockResolvedValue({
      data: null,
      error: { message: "Function error" },
    });

    await expect(deleteAccount()).rejects.toEqual(
      expect.objectContaining({ message: "Function error" }),
    );
    expect(mockAuth.signOut).not.toHaveBeenCalled();
  });

  it("throws when edge function data contains error", async () => {
    mockInvoke.mockResolvedValue({
      data: { error: "Deletion failed" },
      error: null,
    });

    await expect(deleteAccount()).rejects.toThrow("Deletion failed");
    expect(mockAuth.signOut).not.toHaveBeenCalled();
  });
});

// ── fetchSubscription ────────────────────────────────────────────────

describe("fetchSubscription", () => {
  it("returns null when user is not authenticated", async () => {
    getCurrentUserId.mockResolvedValue(null);

    const result = await fetchSubscription();
    expect(result).toBeNull();
  });

  it("returns active subscription", async () => {
    const sub = { id: "sub1", plan: "pro", is_active: true };
    getCurrentUserId.mockResolvedValue("u1");
    const chain = buildQueryMock({ data: sub, error: null });
    mockFrom.mockReturnValue(chain);

    const result = await fetchSubscription();

    expect(mockFrom).toHaveBeenCalledWith("subscriptions");
    expect(result).toEqual(sub);
  });

  it("returns null when no active subscription (PGRST116)", async () => {
    getCurrentUserId.mockResolvedValue("u1");
    const chain = buildQueryMock({
      data: null,
      error: { message: "No rows", code: "PGRST116" },
    });
    mockFrom.mockReturnValue(chain);

    const result = await fetchSubscription();
    expect(result).toBeNull();
  });

  it("throws for non-PGRST116 errors", async () => {
    getCurrentUserId.mockResolvedValue("u1");
    const chain = buildQueryMock({
      data: null,
      error: { message: "Connection error", code: "500" },
    });
    mockFrom.mockReturnValue(chain);

    await expect(fetchSubscription()).rejects.toEqual(
      expect.objectContaining({ message: "Connection error" }),
    );
  });
});
