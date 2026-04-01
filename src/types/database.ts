export interface Profile {
  id: string;
  display_name: string | null;
  avatar_url: string | null;
  language: "tr" | "en";
  currency: "TRY" | "USD" | "EUR";
  timezone: string;
  onboarding_completed: boolean;
  preferences: Record<string, unknown>;
  created_at: string;
  updated_at: string;
}

export interface Category {
  id: string;
  slug: string;
  name_tr: string;
  name_en: string;
  description_tr: string | null;
  description_en: string | null;
  icon: string;
  color: string;
  sort_order: number;
  is_active: boolean;
  created_at: string;
}

export interface Scenario {
  id: string;
  category_id: string;
  slug: string;
  title_tr: string;
  title_en: string;
  description_tr: string;
  description_en: string;
  short_desc_tr: string | null;
  short_desc_en: string | null;
  difficulty: number;
  min_budget: number | null;
  max_budget: number | null;
  min_people: number;
  max_people: number | null;
  prep_days: number;
  indoor_outdoor: "indoor" | "outdoor" | "both";
  season: string[];
  tags: string[];
  cover_image_url: string | null;
  is_premium: boolean;
  is_featured: boolean;
  is_active: boolean;
  rating_avg: number;
  rating_count: number;
  view_count: number;
  created_at: string;
  updated_at: string;
  // Joined
  category?: Category;
  steps?: ScenarioStep[];
  images?: ScenarioImage[];
}

export interface ScenarioStep {
  id: string;
  scenario_id: string;
  step_number: number;
  title_tr: string;
  title_en: string;
  description_tr: string;
  description_en: string;
  is_optional: boolean;
  days_before: number | null;
  estimated_cost: number | null;
  pro_tip_tr: string | null;
  pro_tip_en: string | null;
  created_at: string;
}

export interface ScenarioImage {
  id: string;
  scenario_id: string;
  image_url: string;
  caption_tr: string | null;
  caption_en: string | null;
  sort_order: number;
  created_at: string;
}

export interface Plan {
  id: string;
  user_id: string;
  scenario_id: string | null;
  title: string;
  event_date: string | null;
  event_time: string | null;
  recipient_name: string | null;
  recipient_relation: string | null;
  location_text: string | null;
  location_lat: number | null;
  location_lng: number | null;
  budget: number | null;
  guest_count: number | null;
  notes: string | null;
  status: "planning" | "ready" | "completed" | "cancelled";
  customizations: Record<string, unknown>;
  ai_suggestions: Record<string, unknown>;
  completion_rating: number | null;
  completion_notes: string | null;
  completion_photos: string[];
  completion_data: Record<string, unknown>;
  completed_at: string | null;
  created_at: string;
  updated_at: string;
  // Joined
  scenario?: Scenario;
  checklist?: ChecklistItem[];
}

export interface CompletionData {
  rating?: number;
  notes?: string;
  photos?: string[];
  reactionType?: "happy" | "surprised" | "emotional" | "laughing";
  memoryEntry?: string;
  shareToGallery?: boolean;
}

export interface ChecklistItem {
  id: string;
  plan_id: string;
  step_id: string | null;
  title: string;
  description: string | null;
  is_completed: boolean;
  due_date: string | null;
  sort_order: number;
  completed_at: string | null;
  created_at: string;
  depends_on?: string | null;
}

export interface Review {
  id: string;
  user_id: string;
  scenario_id: string;
  plan_id: string | null;
  rating: number;
  comment: string | null;
  photos: string[];
  is_public: boolean;
  created_at: string;
}

export interface AIInteraction {
  id: string;
  user_id: string;
  prompt_type: "recommendation" | "customization" | "chat";
  input_data: Record<string, unknown>;
  response_data: Record<string, unknown>;
  model_used: string | null;
  tokens_used: number | null;
  rating: number | null;
  created_at: string;
}

export interface Subscription {
  id: string;
  user_id: string;
  revenucat_id: string | null;
  plan_type: "free" | "premium_monthly" | "premium_yearly";
  is_active: boolean;
  started_at: string | null;
  expires_at: string | null;
  created_at: string;
}
