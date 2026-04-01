// NOTE: jest.mock factories are hoisted by babel-jest. Variables referenced
// inside a factory must be prefixed with "mock" (case-insensitive) so that
// babel-jest allows the forward reference. We use `var` (also hoisted) for
// the declarations so the assignments inside the factory are visible outside.

/* eslint-disable no-var */
var mockFrom: jest.Mock;
var mockRpc: jest.Mock;
var mockChain: {
  select: jest.Mock;
  insert: jest.Mock;
  update: jest.Mock;
  delete: jest.Mock;
  eq: jest.Mock;
  neq: jest.Mock;
  or: jest.Mock;
  ilike: jest.Mock;
  order: jest.Mock;
  limit: jest.Mock;
  range: jest.Mock;
  in: jest.Mock;
  single: jest.Mock;
  maybeSingle: jest.Mock;
};
/* eslint-enable no-var */

jest.mock("../../src/services/supabase", () => {
  mockChain = {
    select: jest.fn().mockReturnThis(),
    insert: jest.fn().mockReturnThis(),
    update: jest.fn().mockReturnThis(),
    delete: jest.fn().mockReturnThis(),
    eq: jest.fn().mockReturnThis(),
    neq: jest.fn().mockReturnThis(),
    or: jest.fn().mockReturnThis(),
    ilike: jest.fn().mockReturnThis(),
    order: jest.fn().mockReturnThis(),
    limit: jest.fn().mockReturnThis(),
    range: jest.fn().mockReturnThis(),
    in: jest.fn().mockReturnThis(),
    single: jest.fn().mockResolvedValue({ data: null, error: null }),
    maybeSingle: jest.fn().mockResolvedValue({ data: null, error: null }),
  };
  mockFrom = jest.fn().mockReturnValue(mockChain);
  mockRpc = jest.fn().mockResolvedValue({ data: null, error: null });

  return {
    supabase: {
      from: (...args: unknown[]) => mockFrom(...args),
      rpc: (...args: unknown[]) => mockRpc(...args),
    },
  };
});

jest.mock("../../src/services/helpers", () => ({
  getCurrentUserId: jest.fn().mockResolvedValue("user-123"),
  getCurrentUser: jest.fn().mockResolvedValue({ id: "user-123" }),
}));

jest.mock("../../src/utils/crypto", () => ({
  sanitizeInput: jest.fn((value: string) => value),
  sanitizeQueryParam: jest.fn((value: string) => value),
  stripHtmlTags: jest.fn((value: string) => value),
}));

// ── Imports ───────────────────────────────────────────────────────────────────

import {
  getStories,
  createStory,
  likeStory,
  unlikeStory,
  getTrendingStories,
  getMyStories,
  commentOnStory,
} from "../../src/services/community";
import type { Story, StoryComment } from "../../src/services/community";
import { getCurrentUser, getCurrentUserId } from "../../src/services/helpers";
import {
  sanitizeInput,
  sanitizeQueryParam,
  stripHtmlTags,
} from "../../src/utils/crypto";

const mockGetCurrentUser = getCurrentUser as jest.MockedFunction<
  typeof getCurrentUser
>;
const mockGetCurrentUserId = getCurrentUserId as jest.MockedFunction<
  typeof getCurrentUserId
>;
const mockSanitizeInput = sanitizeInput as jest.MockedFunction<
  typeof sanitizeInput
>;
const mockSanitizeQueryParam = sanitizeQueryParam as jest.MockedFunction<
  typeof sanitizeQueryParam
>;
const mockStripHtmlTags = stripHtmlTags as jest.MockedFunction<
  typeof stripHtmlTags
>;

// ── Fixtures ──────────────────────────────────────────────────────────────────

const makeStory = (overrides: Partial<Story> = {}): Story => ({
  id: "story-1",
  user_id: "user-123",
  title: "Test Story",
  content: "Once upon a time...",
  photos: [],
  category: "birthday",
  likes_count: 0,
  comments_count: 0,
  is_anonymous: false,
  is_reported: false,
  author_name: "Alice",
  author_avatar: null,
  created_at: "2026-01-01T00:00:00Z",
  updated_at: "2026-01-01T00:00:00Z",
  ...overrides,
});

const makeComment = (overrides: Partial<StoryComment> = {}): StoryComment => ({
  id: "comment-1",
  story_id: "story-1",
  user_id: "user-123",
  content: "Great story!",
  author_name: "Alice",
  author_avatar: null,
  created_at: "2026-01-01T00:00:00Z",
  ...overrides,
});

// ── Chain utilities ───────────────────────────────────────────────────────────

/** Reset all chain mock methods to their default pass-through behaviour. */
function resetChain() {
  mockChain.select.mockReset().mockReturnThis();
  mockChain.insert.mockReset().mockReturnThis();
  mockChain.update.mockReset().mockReturnThis();
  mockChain.delete.mockReset().mockReturnThis();
  mockChain.eq.mockReset().mockReturnThis();
  mockChain.neq.mockReset().mockReturnThis();
  mockChain.or.mockReset().mockReturnThis();
  mockChain.ilike.mockReset().mockReturnThis();
  mockChain.order.mockReset().mockReturnThis();
  mockChain.limit.mockReset().mockReturnThis();
  mockChain.range.mockReset().mockReturnThis();
  mockChain.in.mockReset().mockReturnThis();
  mockChain.single.mockReset().mockResolvedValue({ data: null, error: null });
  mockChain.maybeSingle
    .mockReset()
    .mockResolvedValue({ data: null, error: null });
}

/**
 * Return a shallow copy of mockChain where a single terminal method resolves
 * with the provided result. Use this when a query ends at a specific method
 * (e.g. `.range()`, `.single()`, `.limit()`) rather than chaining further.
 */
function terminalChain(
  method: "range" | "single" | "maybeSingle" | "limit" | "in" | "order" | "eq",
  result: { data: unknown; error: unknown },
) {
  return { ...mockChain, [method]: jest.fn().mockResolvedValue(result) };
}

// ── beforeEach ────────────────────────────────────────────────────────────────

beforeEach(() => {
  jest.clearAllMocks();
  mockFrom.mockReturnValue(mockChain);
  mockRpc.mockResolvedValue({ data: null, error: null });
  resetChain();

  mockGetCurrentUserId.mockResolvedValue("user-123");
  mockGetCurrentUser.mockResolvedValue({ id: "user-123" } as any);
  mockSanitizeInput.mockImplementation((value: string) => value);
  mockSanitizeQueryParam.mockImplementation((value: string) => value);
  mockStripHtmlTags.mockImplementation((value: string) => value);
});

// ── getStories ────────────────────────────────────────────────────────────────

describe("community – getStories", () => {
  it("returns stories on success and marks liked ones correctly", async () => {
    const stories = [
      makeStory({ id: "story-1" }),
      makeStory({ id: "story-2" }),
    ];
    let callCount = 0;
    mockFrom.mockImplementation(() => {
      callCount += 1;
      // First call: community_stories — resolves at .range()
      if (callCount === 1)
        return terminalChain("range", { data: stories, error: null });
      // Second call: story_likes — resolves at .in()
      return terminalChain("in", {
        data: [{ story_id: "story-1" }],
        error: null,
      });
    });

    const result = await getStories(1);

    expect(result).toHaveLength(2);
    expect(result.find((s) => s.id === "story-1")?.is_liked_by_me).toBe(true);
    expect(result.find((s) => s.id === "story-2")?.is_liked_by_me).toBe(false);
  });

  it("throws when the database query returns an error", async () => {
    const dbError = new Error("DB connection failed");
    mockFrom.mockReturnValue(
      terminalChain("range", { data: null, error: dbError }),
    );

    await expect(getStories()).rejects.toThrow("DB connection failed");
  });

  it("returns empty array when there are no stories", async () => {
    mockFrom.mockReturnValue(terminalChain("range", { data: [], error: null }));

    const result = await getStories();

    expect(result).toEqual([]);
  });

  it("calculates the correct range for page 2 with default page size of 20", async () => {
    // All chain methods return `this` (the shared mockChain), so the terminal
    // method must be resolved on mockChain itself, not on a spread copy.
    mockChain.range.mockResolvedValue({ data: [], error: null });

    await getStories(2);

    // page=2, pageSize=20 → from=20, to=39
    expect(mockChain.range).toHaveBeenCalledWith(20, 39);
  });

  it("applies category filter when one is provided", async () => {
    // The chain is: .select().eq('is_reported',...).order().range().eq('category',...)
    // The first .eq() (is_reported) must return the chain so .order() is available.
    // The second .eq() (category filter) is the terminal awaited value.
    mockChain.eq
      .mockReturnValueOnce(mockChain) // .eq('is_reported', false) → chain
      .mockResolvedValueOnce({ data: [], error: null }); // .eq('category', ...) → resolves

    await getStories(1, { category: "birthday" });

    expect(mockChain.eq).toHaveBeenCalledWith("category", "birthday");
  });

  it("sanitizes the search term and applies an OR filter", async () => {
    // .range() and .eq() return the chain; .or() is the terminal resolver.
    mockChain.range.mockReturnThis();
    mockChain.or.mockResolvedValue({ data: [], error: null });

    await getStories(1, { search: "wedding <script>" });

    expect(mockSanitizeQueryParam).toHaveBeenCalledWith("wedding <script>");
    expect(mockChain.or).toHaveBeenCalled();
  });

  it("skips the likes lookup when no user is authenticated", async () => {
    mockGetCurrentUserId.mockResolvedValue(null as any);
    mockFrom.mockReturnValue(
      terminalChain("range", { data: [makeStory()], error: null }),
    );

    const result = await getStories();

    // Only the community_stories call should be made; no story_likes call
    expect(mockFrom).toHaveBeenCalledTimes(1);
    expect(result).toHaveLength(1);
  });
});

// ── createStory ───────────────────────────────────────────────────────────────

describe("community – createStory", () => {
  it("inserts a sanitized story and returns the created record", async () => {
    const newStory = makeStory({
      title: "My Birthday",
      content: "A great day",
    });
    let callCount = 0;
    mockFrom.mockImplementation(() => {
      callCount += 1;
      if (callCount === 1) {
        return terminalChain("maybeSingle", {
          data: { display_name: "Alice", avatar_url: null },
          error: null,
        });
      }
      return terminalChain("single", { data: newStory, error: null });
    });

    const result = await createStory({
      title: "My Birthday",
      content: "A great day",
      category: "birthday",
    });

    expect(result).toEqual(newStory);
    expect(mockSanitizeInput).toHaveBeenCalledWith("My Birthday", 200);
    expect(mockSanitizeInput).toHaveBeenCalledWith("A great day", 5000);
    expect(mockStripHtmlTags).toHaveBeenCalledTimes(2);
  });

  it("sets author_name and author_avatar to null when story is anonymous", async () => {
    const capturedPayloads: unknown[] = [];
    const newStory = makeStory({
      is_anonymous: true,
      author_name: null,
      author_avatar: null,
    });
    let callCount = 0;

    mockFrom.mockImplementation(() => {
      callCount += 1;
      if (callCount === 1) {
        return terminalChain("maybeSingle", {
          data: {
            display_name: "Alice",
            avatar_url: "https://example.com/avatar.png",
          },
          error: null,
        });
      }
      return {
        ...mockChain,
        insert: jest.fn().mockImplementation((payload: unknown) => {
          capturedPayloads.push(payload);
          return terminalChain("single", { data: newStory, error: null });
        }),
      };
    });

    await createStory({
      title: "Anonymous Post",
      content: "Hidden author",
      category: "other",
      is_anonymous: true,
    });

    const inserted = capturedPayloads[0] as Record<string, unknown>;
    expect(inserted?.author_name).toBeNull();
    expect(inserted?.author_avatar).toBeNull();
  });

  it("throws when the insert returns an error", async () => {
    const dbError = new Error("Insert failed");
    let callCount = 0;
    mockFrom.mockImplementation(() => {
      callCount += 1;
      if (callCount === 1)
        return terminalChain("maybeSingle", { data: null, error: null });
      return terminalChain("single", { data: null, error: dbError });
    });

    await expect(
      createStory({ title: "Fail", content: "Bad", category: "other" }),
    ).rejects.toThrow("Insert failed");
  });
});

// ── likeStory ─────────────────────────────────────────────────────────────────

describe("community – likeStory", () => {
  it("inserts a like record and calls rpc to increment the count", async () => {
    mockFrom.mockReturnValue({
      ...mockChain,
      insert: jest.fn().mockResolvedValue({ data: null, error: null }),
    });

    await likeStory("story-1");

    expect(mockFrom).toHaveBeenCalledWith("story_likes");
    expect(mockRpc).toHaveBeenCalledWith("increment_story_likes", {
      story_id: "story-1",
    });
  });

  it("silently ignores a duplicate constraint violation (code 23505)", async () => {
    const duplicateError = { code: "23505", message: "duplicate key value" };
    mockFrom.mockReturnValue({
      ...mockChain,
      insert: jest
        .fn()
        .mockResolvedValue({ data: null, error: duplicateError }),
    });

    await expect(likeStory("story-1")).resolves.toBeUndefined();
    // rpc must NOT fire when the story is already liked
    expect(mockRpc).not.toHaveBeenCalled();
  });

  it("throws for non-duplicate insert errors", async () => {
    const dbError = { code: "42501", message: "permission denied" };
    mockFrom.mockReturnValue({
      ...mockChain,
      insert: jest.fn().mockResolvedValue({ data: null, error: dbError }),
    });

    await expect(likeStory("story-1")).rejects.toEqual(dbError);
  });
});

// ── unlikeStory ───────────────────────────────────────────────────────────────

describe("community – unlikeStory", () => {
  it("deletes the like record and calls rpc to decrement the count", async () => {
    // The service chain is: .delete().eq(story_id).eq(user_id) — the second
    // .eq() is the terminal promise. Model the chain accordingly.
    const secondEq = jest.fn().mockResolvedValue({ data: null, error: null });
    const firstEq = jest.fn().mockReturnValue({ ...mockChain, eq: secondEq });
    mockFrom.mockReturnValue({
      ...mockChain,
      delete: jest.fn().mockReturnValue({ ...mockChain, eq: firstEq }),
    });

    await unlikeStory("story-1");

    expect(mockFrom).toHaveBeenCalledWith("story_likes");
    expect(mockRpc).toHaveBeenCalledWith("decrement_story_likes", {
      story_id: "story-1",
    });
  });

  it("throws when the delete query returns an error", async () => {
    const dbError = new Error("Delete failed");
    const secondEq = jest
      .fn()
      .mockResolvedValue({ data: null, error: dbError });
    const firstEq = jest.fn().mockReturnValue({ ...mockChain, eq: secondEq });
    mockFrom.mockReturnValue({
      ...mockChain,
      delete: jest.fn().mockReturnValue({ ...mockChain, eq: firstEq }),
    });

    await expect(unlikeStory("story-1")).rejects.toThrow("Delete failed");
  });
});

// ── getTrendingStories ────────────────────────────────────────────────────────

describe("community – getTrendingStories", () => {
  it("returns stories ordered by likes_count then comments_count", async () => {
    const stories = [
      makeStory({ id: "story-hot", likes_count: 100, comments_count: 20 }),
      makeStory({ id: "story-warm", likes_count: 50, comments_count: 5 }),
    ];
    mockChain.limit.mockResolvedValue({ data: stories, error: null });

    const result = await getTrendingStories(10);

    expect(result).toHaveLength(2);
    expect(result[0].id).toBe("story-hot");
    expect(mockChain.order).toHaveBeenCalledWith("likes_count", {
      ascending: false,
    });
    expect(mockChain.order).toHaveBeenCalledWith("comments_count", {
      ascending: false,
    });
    expect(mockChain.limit).toHaveBeenCalledWith(10);
  });

  it("returns empty array when data is null", async () => {
    mockFrom.mockReturnValue(
      terminalChain("limit", { data: null, error: null }),
    );

    const result = await getTrendingStories();

    expect(result).toEqual([]);
  });

  it("throws when the database returns an error", async () => {
    const dbError = new Error("Trending query failed");
    mockFrom.mockReturnValue(
      terminalChain("limit", { data: null, error: dbError }),
    );

    await expect(getTrendingStories()).rejects.toThrow("Trending query failed");
  });
});

// ── getMyStories ──────────────────────────────────────────────────────────────

describe("community – getMyStories", () => {
  it("returns all stories belonging to the authenticated user", async () => {
    const userStories = [
      makeStory({ id: "my-story-1" }),
      makeStory({ id: "my-story-2" }),
    ];
    mockFrom.mockReturnValue({
      ...mockChain,
      order: jest.fn().mockResolvedValue({ data: userStories, error: null }),
    });

    const result = await getMyStories();

    expect(result).toHaveLength(2);
    expect(mockChain.eq).toHaveBeenCalledWith("user_id", "user-123");
  });

  it("returns empty array when the user has no stories", async () => {
    mockFrom.mockReturnValue(
      terminalChain("order", { data: null, error: null }),
    );

    const result = await getMyStories();

    expect(result).toEqual([]);
  });

  it("throws when no user is authenticated", async () => {
    mockGetCurrentUser.mockRejectedValue(new Error("Not authenticated"));

    await expect(getMyStories()).rejects.toThrow("Not authenticated");
  });
});

// ── commentOnStory ────────────────────────────────────────────────────────────

describe("community – commentOnStory", () => {
  it("inserts a sanitized comment, increments the count, and returns the record", async () => {
    const newComment = makeComment({ content: "What a lovely event!" });
    let callCount = 0;
    mockFrom.mockImplementation(() => {
      callCount += 1;
      if (callCount === 1) {
        return terminalChain("maybeSingle", {
          data: { display_name: "Alice", avatar_url: null },
          error: null,
        });
      }
      return terminalChain("single", { data: newComment, error: null });
    });

    const result = await commentOnStory("story-1", "What a lovely event!");

    expect(result).toEqual(newComment);
    expect(mockSanitizeInput).toHaveBeenCalledWith(
      "What a lovely event!",
      1000,
    );
    expect(mockStripHtmlTags).toHaveBeenCalled();
    expect(mockRpc).toHaveBeenCalledWith("increment_story_comments", {
      story_id: "story-1",
    });
  });

  it("stores null author fields when the user profile has no display_name", async () => {
    const capturedPayloads: unknown[] = [];
    const newComment = makeComment({ author_name: null });
    let callCount = 0;

    mockFrom.mockImplementation(() => {
      callCount += 1;
      if (callCount === 1) {
        return terminalChain("maybeSingle", {
          data: { display_name: null, avatar_url: null },
          error: null,
        });
      }
      return {
        ...mockChain,
        insert: jest.fn().mockImplementation((payload: unknown) => {
          capturedPayloads.push(payload);
          return terminalChain("single", { data: newComment, error: null });
        }),
      };
    });

    await commentOnStory("story-1", "Hello");

    const inserted = capturedPayloads[0] as Record<string, unknown>;
    expect(inserted?.author_name).toBeNull();
  });

  it("throws when no user is authenticated", async () => {
    mockGetCurrentUser.mockRejectedValue(new Error("Not authenticated"));

    await expect(commentOnStory("story-1", "Hello")).rejects.toThrow(
      "Not authenticated",
    );
  });

  it("throws when the comment insert fails", async () => {
    const dbError = new Error("Comment insert failed");
    let callCount = 0;
    mockFrom.mockImplementation(() => {
      callCount += 1;
      if (callCount === 1)
        return terminalChain("maybeSingle", { data: null, error: null });
      return terminalChain("single", { data: null, error: dbError });
    });

    await expect(commentOnStory("story-1", "Oops")).rejects.toThrow(
      "Comment insert failed",
    );
  });
});
