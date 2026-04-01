import { supabase } from './supabase';
import { getCurrentUserId } from './helpers';

// ==========================================
// AI Service - Calls Supabase Edge Functions
// ==========================================

interface AIRecommendationInput {
  occasion: string;
  recipient?: string;
  budget_min?: number;
  budget_max?: number;
  guest_count?: number;
  indoor_outdoor?: string;
  season?: string;
  preferences?: string;
  language: 'tr' | 'en';
}

interface AIRecommendationResponse {
  recommendations: Array<{
    scenario_id: string;
    score: number;
    reason_tr: string;
    reason_en: string;
  }>;
  general_tips_tr: string;
  general_tips_en: string;
}

interface AIPlanCustomizationInput {
  plan_id: string;
  scenario_id: string;
  event_date?: string;
  budget?: number;
  guest_count?: number;
  recipient_name?: string;
  recipient_relation?: string;
  special_requests?: string;
  language: 'tr' | 'en';
}

interface AIPlanCustomizationResponse {
  customized_steps: Array<{
    step_number: number;
    title: string;
    description: string;
    tips: string;
    estimated_cost?: number;
  }>;
  budget_breakdown: {
    total_estimated: number;
    items: Array<{ name: string; cost: number }>;
  };
  additional_tips: string[];
}

interface AIChatInput {
  message: string;
  context?: {
    plan_id?: string;
    scenario_id?: string;
  };
  conversation_history?: Array<{ role: 'user' | 'assistant'; content: string }>;
  language: 'tr' | 'en';
}

interface AIChatResponse {
  reply: string;
  suggested_actions?: Array<{
    type: 'view_scenario' | 'create_plan' | 'update_checklist';
    label: string;
    data: Record<string, string>;
  }>;
}

async function callEdgeFunction<T>(functionName: string, body: Record<string, unknown> | object): Promise<T> {
  const { data, error } = await supabase.functions.invoke(functionName, {
    body,
  });

  if (error) throw error;
  return data as T;
}

export async function getAIRecommendations(input: AIRecommendationInput): Promise<AIRecommendationResponse> {
  return callEdgeFunction<AIRecommendationResponse>('ai-recommend', input);
}

export async function getAIPlanCustomization(input: AIPlanCustomizationInput): Promise<AIPlanCustomizationResponse> {
  return callEdgeFunction<AIPlanCustomizationResponse>('ai-customize-plan', input);
}

export async function sendAIChatMessage(input: AIChatInput): Promise<AIChatResponse> {
  return callEdgeFunction<AIChatResponse>('ai-chat', input);
}

// Save AI interaction for analytics
export async function saveAIInteraction(promptType: string, inputData: Record<string, unknown>, responseData: Record<string, unknown>, modelUsed: string, tokensUsed?: number) {
  const userId = await getCurrentUserId();
  if (!userId) return;

  await supabase.from('ai_interactions').insert({
    user_id: userId,
    prompt_type: promptType,
    input_data: inputData,
    response_data: responseData,
    model_used: modelUsed,
    tokens_used: tokensUsed,
  });
}
