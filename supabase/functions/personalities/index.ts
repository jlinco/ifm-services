// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts';
import { SupabaseClient, createClient } from 'https://esm.sh/@supabase/supabase-js@2';
import { corsHeaders } from '../_shared/cors.ts';
import { Database } from '../../../ifmtypes.gen';

// TO DO: generate types for supabase to use typescript features

// list all personalities
async function getAllPersonalities(client: SupabaseClient) {
  const { data: personalities, error } = await client.from('personalities').select('*');
  if (error) throw error

  return new Response(JSON.stringify({ personalities }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200
  })
}

// update personality with ID
// TODO: add auth guard to prevent unwanted changes
async function updatePersonality(id: string, client: SupabaseClient, personality: any) {
  const { error } = await client.from('personalities').update(personality).eq('personality_id', id)
  if (error) throw error

  return new Response(JSON.stringify({ personality }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200
  })
}

serve(async(req) => {

  const { url, method } = req

  try {
    const supabase = createClient<Database>(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )

    const taskPattern = new URLPattern({ pathname: '/personalities/:id' })
    const matchingPath = taskPattern.exec(url)
    const id = matchingPath ? matchingPath.pathname.groups.id : null

    let personality = null
    if (method === 'POST' || method === 'PUT') {
      const body = await req.json()
      personality = body.personality
    }


    switch (true) {
      case method === 'GET':
        return getAllPersonalities(supabase)

      case id && method === 'PUT':
        return updatePersonality(id, supabase, personality)
        
      default:
        return getAllPersonalities(supabase)
    }
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': "application/json" },
      status: 400
    })
  }

})

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
