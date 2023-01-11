// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient, SupabaseClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  const supabaseClient = SupabaseClient(
    'https://lgxdqrfjcrugbqjdoxlg.supabase.co',
    // Supabase API ANON KEY - env var exported by default.
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxneGRxcmZqY3J1Z2JxamRveGxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzIzMDMzMzMsImV4cCI6MTk4Nzg3OTMzM30.XufNcZArc48rsfRKtOM54hSs9uNi4-w-HVpl-jM61sg',
    // Create client with Auth context of the user that called the function.
    // This way your row-level-security (RLS) policies are applied.
    { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
  )
  const { data: transaction, error } = await supabaseClient.from('transaction').select('*')
  if (error) throw error

  return new Response(JSON.stringify({ transaction }), {
    headers: {'Content-Type': 'application/json' },
    status: 200,
  })
})

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
