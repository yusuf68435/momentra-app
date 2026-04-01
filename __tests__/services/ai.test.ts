import {
  getAIRecommendations,
  sendAIChatMessage,
  saveAIInteraction,
} from "../../src/services/ai";
import {
  getActiveConversation,
  createConversation,
  appendMessage,
  getConversationHistory,
  deleteConversation,
} from "../../src/services/aiConversations";
import type { ConversationMessage } from "../../src/services/aiConversations";

// ── Module mocks ──────────────────────────────────────────────────────

jest.mock("../../src/services/supabase", () => ({
  supabase: {
    from: jest.fn(),
    functions: {
      invoke: jest.fn(),
    },
  },
}));

jest.mock("../../src/services/helpers", () => ({
  getCurrentUserId: jest.fn(),
}));

// ── Imports after mocks ───────────────────────────────────────────────

import { supabase } from "../../src/services/supabase";
import { getCurrentUserId } from "../../src/services/helpers";

const mockedInvoke = supabase.functions.invoke as jest.MockedFunction<
  typeof supabase.functions.invoke
>;
const mockedFrom = supabase.from as jest.MockedFunction<typeof supabase.from>;
const mockedGetCurrentUserId = getCurrentUserId as jest.MockedFunction<
  typeof getCurrentUserId
>;

// ── Helpers ───────────────────────────────────────────────────────────

function buildChain(overrides: Record<string, jest.Mock> = {}) {
  const chain: Record<string, jest.Mock> = {
    select: jest.fn().mockReturnThis(),
    insert: jest.fn().mockReturnThis(),
    update: jest.fn().mockReturnThis(),
    delete: jest.fn().mockReturnThis(),
    eq: jest.fn().mockReturnThis(),
    order: jest.fn().mockReturnThis(),
    limit: jest.fn().mockReturnThis(),
    single: jest.fn().mockResolvedValue({ data: null, error: null }),
    maybeSingle: jest.fn().mockResolvedValue({ data: null, error: null }),
    ...overrides,
  };
  // Make non-overridden chainable methods return the chain object
  Object.keys(chain).forEach((key) => {
    if (key !== "single" && key !== "maybeSingle" && !(key in overrides)) {
      chain[key].mockReturnThis();
    }
  });
  return chain;
}

// ── ai.ts ─────────────────────────────────────────────────────────────

describe("ai – getAIRecommendations", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns recommendation data on success", async () => {
    const mockResponse = {
      recommendations: [
        { scenario_id: "abc", score: 0.9, reason_tr: "İyi", reason_en: "Good" },
      ],
      general_tips_tr: "İpucu",
      general_tips_en: "Tip",
    };
    mockedInvoke.mockResolvedValueOnce({ data: mockResponse, error: null });

    const result = await getAIRecommendations({
      occasion: "birthday",
      language: "tr",
    });

    expect(mockedInvoke).toHaveBeenCalledWith("ai-recommend", {
      body: { occasion: "birthday", language: "tr" },
    });
    expect(result).toEqual(mockResponse);
  });

  it("propagates error thrown by edge function", async () => {
    const edgeError = new Error("Edge function failed");
    mockedInvoke.mockResolvedValueOnce({ data: null, error: edgeError });

    await expect(
      getAIRecommendations({ occasion: "anniversary", language: "en" }),
    ).rejects.toThrow("Edge function failed");
  });
});

describe("ai – sendAIChatMessage", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns chat reply on success", async () => {
    const mockReply = {
      reply: "Hello!",
      suggested_actions: [
        { type: "navigate", label: "Go", data: { route: "/home" } },
      ],
    };
    mockedInvoke.mockResolvedValueOnce({ data: mockReply, error: null });

    const result = await sendAIChatMessage({
      message: "Help me plan",
      language: "en",
    });

    expect(mockedInvoke).toHaveBeenCalledWith("ai-chat", {
      body: { message: "Help me plan", language: "en" },
    });
    expect(result).toEqual(mockReply);
  });

  it("throws when edge function returns an error", async () => {
    const edgeError = new Error("Timeout");
    mockedInvoke.mockResolvedValueOnce({ data: null, error: edgeError });

    await expect(
      sendAIChatMessage({ message: "test", language: "tr" }),
    ).rejects.toThrow("Timeout");
  });

  it("passes conversation history and context to edge function", async () => {
    mockedInvoke.mockResolvedValueOnce({
      data: { reply: "ok" },
      error: null,
    });

    await sendAIChatMessage({
      message: "Continue",
      context: { plan_id: "plan-1", scenario_id: "sc-1" },
      conversation_history: [{ role: "user", content: "Hello" }],
      language: "en",
    });

    expect(mockedInvoke).toHaveBeenCalledWith("ai-chat", {
      body: expect.objectContaining({
        context: { plan_id: "plan-1", scenario_id: "sc-1" },
        conversation_history: [{ role: "user", content: "Hello" }],
      }),
    });
  });
});

describe("ai – saveAIInteraction", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("skips insert when no authenticated user", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce(null);

    await saveAIInteraction("recommend", {}, {}, "gpt-4o-mini");

    expect(mockedFrom).not.toHaveBeenCalled();
  });

  it("inserts interaction record when user is authenticated", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-123");
    const chain = buildChain({
      insert: jest.fn().mockResolvedValue({ data: null, error: null }),
    });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    await saveAIInteraction(
      "recommend",
      { occasion: "birthday" },
      { recommendations: [] },
      "gpt-4o-mini",
      150,
    );

    expect(mockedFrom).toHaveBeenCalledWith("ai_interactions");
    expect(chain.insert).toHaveBeenCalledWith({
      user_id: "user-123",
      prompt_type: "recommend",
      input_data: { occasion: "birthday" },
      response_data: { recommendations: [] },
      model_used: "gpt-4o-mini",
      tokens_used: 150,
    });
  });

  it("inserts without tokens_used when not provided", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-456");
    const chain = buildChain({
      insert: jest.fn().mockResolvedValue({ data: null, error: null }),
    });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    await saveAIInteraction("chat", {}, {}, "gpt-4o-mini");

    expect(chain.insert).toHaveBeenCalledWith(
      expect.objectContaining({ tokens_used: undefined }),
    );
  });
});

// ── aiConversations.ts ────────────────────────────────────────────────

describe("aiConversations – getActiveConversation", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns null when no authenticated user", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce(null);

    const result = await getActiveConversation();

    expect(result).toBeNull();
    expect(mockedFrom).not.toHaveBeenCalled();
  });

  it("returns conversation data when found", async () => {
    const mockConversation = {
      id: "conv-1",
      user_id: "user-1",
      title: "Birthday chat",
      is_active: true,
      messages: [],
      created_at: "2026-01-01T00:00:00Z",
      updated_at: "2026-01-01T00:00:00Z",
      context_plan_id: null,
      context_scenario_id: null,
    };
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");
    const chain = buildChain({
      maybeSingle: jest
        .fn()
        .mockResolvedValue({ data: mockConversation, error: null }),
    });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    const result = await getActiveConversation();

    expect(mockedFrom).toHaveBeenCalledWith("ai_conversations");
    expect(chain.eq).toHaveBeenCalledWith("user_id", "user-1");
    expect(chain.eq).toHaveBeenCalledWith("is_active", true);
    expect(result).toEqual(mockConversation);
  });

  it("returns null when no active conversation found", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");
    const chain = buildChain({
      maybeSingle: jest.fn().mockResolvedValue({ data: null, error: null }),
    });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    const result = await getActiveConversation();

    expect(result).toBeNull();
  });
});

describe("aiConversations – createConversation", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns null when no authenticated user", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce(null);

    const result = await createConversation();

    expect(result).toBeNull();
    expect(mockedFrom).not.toHaveBeenCalled();
  });

  it("creates a new conversation and returns it", async () => {
    const mockCreated = {
      id: "conv-new",
      user_id: "user-1",
      title: "22.03.2026",
      is_active: true,
      messages: [],
      created_at: "2026-03-22T00:00:00Z",
      updated_at: "2026-03-22T00:00:00Z",
      context_plan_id: null,
      context_scenario_id: null,
    };
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");

    // First call: update existing active conversations
    const updateChain = buildChain({
      update: jest.fn().mockReturnThis(),
    });
    // Second call: insert new conversation
    const insertChain = buildChain({
      insert: jest.fn().mockReturnThis(),
      select: jest.fn().mockReturnThis(),
      single: jest.fn().mockResolvedValue({ data: mockCreated, error: null }),
    });

    mockedFrom
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(insertChain as unknown as ReturnType<typeof supabase.from>);

    const result = await createConversation({ title: "22.03.2026" });

    expect(mockedFrom).toHaveBeenCalledWith("ai_conversations");
    expect(result).toEqual(mockCreated);
  });

  it("returns null when insert fails", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");

    const updateChain = buildChain();
    const insertChain = buildChain({
      insert: jest.fn().mockReturnThis(),
      select: jest.fn().mockReturnThis(),
      single: jest
        .fn()
        .mockResolvedValue({ data: null, error: new Error("Insert failed") }),
    });

    mockedFrom
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(insertChain as unknown as ReturnType<typeof supabase.from>);

    const result = await createConversation();

    expect(result).toBeNull();
  });

  it("passes planId and scenarioId as context", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");

    const updateChain = buildChain();
    const insertChain = buildChain({
      insert: jest.fn().mockReturnThis(),
      select: jest.fn().mockReturnThis(),
      single: jest
        .fn()
        .mockResolvedValue({ data: { id: "conv-ctx" }, error: null }),
    });

    mockedFrom
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(insertChain as unknown as ReturnType<typeof supabase.from>);

    await createConversation({ planId: "plan-1", scenarioId: "sc-2" });

    expect(insertChain.insert).toHaveBeenCalledWith(
      expect.objectContaining({
        context_plan_id: "plan-1",
        context_scenario_id: "sc-2",
      }),
    );
  });
});

describe("aiConversations – appendMessage", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("does nothing when conversation is not found", async () => {
    const selectChain = buildChain({
      single: jest.fn().mockResolvedValue({ data: null, error: null }),
    });
    mockedFrom.mockReturnValueOnce(
      selectChain as unknown as ReturnType<typeof supabase.from>,
    );

    const newMessage: ConversationMessage = {
      role: "user",
      content: "Hello",
      timestamp: new Date().toISOString(),
    };

    await appendMessage("conv-missing", newMessage);

    // Only one from() call — no update should be made
    expect(mockedFrom).toHaveBeenCalledTimes(1);
  });

  it("appends message to existing messages and updates", async () => {
    const existingMessages: ConversationMessage[] = [
      { role: "assistant", content: "Hi", timestamp: "2026-01-01T00:00:00Z" },
    ];
    const selectChain = buildChain({
      single: jest.fn().mockResolvedValue({
        data: { messages: existingMessages },
        error: null,
      }),
    });
    const updateChain = buildChain({
      update: jest.fn().mockReturnThis(),
    });

    mockedFrom
      .mockReturnValueOnce(selectChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>);

    const newMessage: ConversationMessage = {
      role: "user",
      content: "What should I plan?",
      timestamp: "2026-01-01T00:01:00Z",
    };

    await appendMessage("conv-1", newMessage);

    expect(updateChain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        messages: [...existingMessages, newMessage],
      }),
    );
    expect(updateChain.eq).toHaveBeenCalledWith("id", "conv-1");
  });

  it("trims messages to last 50 when limit is exceeded", async () => {
    const manyMessages: ConversationMessage[] = Array.from(
      { length: 50 },
      (_, i) => ({
        role: "assistant" as const,
        content: `Message ${i}`,
        timestamp: `2026-01-01T00:${String(i).padStart(2, "0")}:00Z`,
      }),
    );
    const selectChain = buildChain({
      single: jest
        .fn()
        .mockResolvedValue({ data: { messages: manyMessages }, error: null }),
    });
    const updateChain = buildChain({
      update: jest.fn().mockReturnThis(),
    });

    mockedFrom
      .mockReturnValueOnce(selectChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>);

    const overflowMessage: ConversationMessage = {
      role: "user",
      content: "Message 50",
      timestamp: "2026-01-01T01:00:00Z",
    };

    await appendMessage("conv-1", overflowMessage);

    const updateArg = updateChain.update.mock.calls[0][0] as {
      messages: ConversationMessage[];
    };
    expect(updateArg.messages).toHaveLength(50);
    // Should keep the last 50 (drop first, keep messages[1..49] + new)
    expect(updateArg.messages[49]).toEqual(overflowMessage);
  });

  it("auto-sets title from first user message content (up to 60 chars)", async () => {
    const selectChain = buildChain({
      single: jest
        .fn()
        .mockResolvedValue({ data: { messages: [] }, error: null }),
    });
    const updateChain = buildChain({
      update: jest.fn().mockReturnThis(),
    });

    mockedFrom
      .mockReturnValueOnce(selectChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>);

    const firstMessage: ConversationMessage = {
      role: "user",
      content: "Help me plan a birthday surprise for my wife",
      timestamp: "2026-01-01T00:00:00Z",
    };

    await appendMessage("conv-1", firstMessage);

    expect(updateChain.update).toHaveBeenCalledWith(
      expect.objectContaining({
        title: "Help me plan a birthday surprise for my wife",
      }),
    );
  });

  it("truncates auto-title at 60 chars with ellipsis when content is longer", async () => {
    const selectChain = buildChain({
      single: jest
        .fn()
        .mockResolvedValue({ data: { messages: [] }, error: null }),
    });
    const updateChain = buildChain({
      update: jest.fn().mockReturnThis(),
    });

    mockedFrom
      .mockReturnValueOnce(selectChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>);

    const longContent = "A".repeat(80);
    const firstMessage: ConversationMessage = {
      role: "user",
      content: longContent,
      timestamp: "2026-01-01T00:00:00Z",
    };

    await appendMessage("conv-1", firstMessage);

    const updateArg = updateChain.update.mock.calls[0][0] as { title: string };
    expect(updateArg.title).toBe("A".repeat(60) + "...");
  });

  it("does NOT set title when messages already exist", async () => {
    const existingMessages: ConversationMessage[] = [
      {
        role: "user",
        content: "Previous message",
        timestamp: "2026-01-01T00:00:00Z",
      },
    ];
    const selectChain = buildChain({
      single: jest.fn().mockResolvedValue({
        data: { messages: existingMessages },
        error: null,
      }),
    });
    const updateChain = buildChain({
      update: jest.fn().mockReturnThis(),
    });

    mockedFrom
      .mockReturnValueOnce(selectChain as unknown as ReturnType<typeof supabase.from>)
      .mockReturnValueOnce(updateChain as unknown as ReturnType<typeof supabase.from>);

    const secondMessage: ConversationMessage = {
      role: "user",
      content: "Second message",
      timestamp: "2026-01-01T00:01:00Z",
    };

    await appendMessage("conv-1", secondMessage);

    const updateArg = updateChain.update.mock.calls[0][0] as Record<
      string,
      unknown
    >;
    expect(updateArg.title).toBeUndefined();
  });
});

describe("aiConversations – getConversationHistory", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("returns empty array when no authenticated user", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce(null);

    const result = await getConversationHistory();

    expect(result).toEqual([]);
    expect(mockedFrom).not.toHaveBeenCalled();
  });

  it("returns conversation list for authenticated user", async () => {
    const mockConversations = [
      {
        id: "c1",
        title: "Chat 1",
        is_active: false,
        created_at: "",
        updated_at: "",
      },
      {
        id: "c2",
        title: "Chat 2",
        is_active: true,
        created_at: "",
        updated_at: "",
      },
    ];
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");
    const chain = buildChain({
      limit: jest
        .fn()
        .mockResolvedValue({ data: mockConversations, error: null }),
    });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    const result = await getConversationHistory();

    expect(mockedFrom).toHaveBeenCalledWith("ai_conversations");
    expect(result).toEqual(mockConversations);
  });

  it("returns empty array when query returns null data", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");
    const chain = buildChain({
      limit: jest.fn().mockResolvedValue({ data: null, error: null }),
    });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    const result = await getConversationHistory();

    expect(result).toEqual([]);
  });

  it("passes custom limit to query", async () => {
    mockedGetCurrentUserId.mockResolvedValueOnce("user-1");
    const limitMock = jest.fn().mockResolvedValue({ data: [], error: null });
    const chain = buildChain({ limit: limitMock });
    mockedFrom.mockReturnValueOnce(chain as unknown as ReturnType<typeof supabase.from>);

    await getConversationHistory(25);

    expect(limitMock).toHaveBeenCalledWith(25);
  });
});

describe("aiConversations – deleteConversation", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("calls delete with the correct conversation id", async () => {
    const eqMock = jest.fn().mockResolvedValue({ data: null, error: null });
    const deleteMock = jest.fn().mockReturnValue({ eq: eqMock });
    mockedFrom.mockReturnValueOnce({
      delete: deleteMock,
    } as unknown as unknown as ReturnType<typeof supabase.from>);

    await deleteConversation("conv-to-delete");

    expect(mockedFrom).toHaveBeenCalledWith("ai_conversations");
    expect(deleteMock).toHaveBeenCalled();
    expect(eqMock).toHaveBeenCalledWith("id", "conv-to-delete");
  });
});
