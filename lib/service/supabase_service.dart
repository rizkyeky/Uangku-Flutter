part of _service;

class SupabaseService {
  SupabaseService();
  final SupabaseClient _client = SupabaseClient(
    'https://lgxdqrfjcrugbqjdoxlg.supabase.co', 
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6'
    'ImxneGRxcmZqY3J1Z2JxamRveGxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzIzMDMzM'
    'zMsImV4cCI6MTk4Nzg3OTMzM30.XufNcZArc48rsfRKtOM54hSs9uNi4-w-HVpl-jM61sg'
  );
  SupabaseClient get client => _client;
}