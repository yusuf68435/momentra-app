import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Missing authorization header' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Create client with user's JWT to verify identity
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

    const userClient = createClient(supabaseUrl, Deno.env.get('SUPABASE_ANON_KEY')!, {
      global: { headers: { Authorization: authHeader } },
    });

    const { data: { user }, error: userError } = await userClient.auth.getUser();
    if (userError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const userId = user.id;

    // Use service role client to delete all user data (bypasses RLS)
    const adminClient = createClient(supabaseUrl, supabaseServiceKey);

    // Delete in correct order (foreign key dependencies)
    // 1. AI interactions
    await adminClient.from('ai_interactions').delete().eq('user_id', userId);

    // 2. Plan checklist items (via plans)
    const { data: userPlans } = await adminClient.from('plans').select('id').eq('user_id', userId);
    if (userPlans?.length) {
      const planIds = userPlans.map((p: any) => p.id);
      await adminClient.from('plan_checklist_items').delete().in('plan_id', planIds);
      await adminClient.from('co_organizer_tasks').delete().in('plan_id', planIds);
    }

    // 3. Reviews
    await adminClient.from('reviews').delete().eq('user_id', userId);

    // 4. Plans
    await adminClient.from('plans').delete().eq('user_id', userId);

    // 5. Subscriptions
    await adminClient.from('subscriptions').delete().eq('user_id', userId);

    // 6. Profile
    await adminClient.from('profiles').delete().eq('id', userId);

    // 7. Delete the auth user
    const { error: deleteError } = await adminClient.auth.admin.deleteUser(userId);
    if (deleteError) {
      console.error('Failed to delete auth user:', deleteError);
      return new Response(JSON.stringify({ error: 'Failed to delete account' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    return new Response(JSON.stringify({ success: true }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('Delete account error:', error);
    return new Response(JSON.stringify({ error: 'Internal server error' }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
