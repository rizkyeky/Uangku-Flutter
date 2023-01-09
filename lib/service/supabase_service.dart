part of _service;

class SupabaseService {
  
  SupabaseService({
    required String url,
    required String apiKey,
  }) : _client = SupabaseClient(url, apiKey);
  
  final SupabaseClient _client;
  
  SupabaseClient get client => _client;
}