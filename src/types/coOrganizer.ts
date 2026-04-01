export interface CoOrganizer {
  id: string;
  plan_id: string;
  user_id: string | null;
  email: string;
  display_name: string;
  role: 'organizer' | 'helper';
  status: 'pending' | 'accepted' | 'declined';
  invited_at: string;
  accepted_at: string | null;
  // Joined
  profile?: {
    display_name: string;
    avatar_url: string | null;
  };
}

export interface PlanMessage {
  id: string;
  plan_id: string;
  sender_id: string;
  message: string;
  message_type: 'text' | 'image' | 'system';
  created_at: string;
  // Joined
  sender?: {
    display_name: string;
    avatar_url: string | null;
  };
}

export interface TaskAssignment {
  id: string;
  plan_id: string;
  checklist_item_id: string;
  assigned_to: string; // user_id
  assigned_by: string; // user_id
  status: 'pending' | 'accepted' | 'completed';
  created_at: string;
  // Joined
  assignee?: {
    display_name: string;
    avatar_url: string | null;
  };
  checklist_item?: {
    title: string;
    is_completed: boolean;
  };
}

export interface InviteLink {
  id: string;
  plan_id: string;
  code: string;
  created_by: string;
  max_uses: number;
  use_count: number;
  expires_at: string;
  is_active: boolean;
  created_at: string;
}
