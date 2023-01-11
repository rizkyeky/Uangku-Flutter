part of _service;

class FunctionService {

  FunctionService({
    required SupabaseClient client
  }) :
  _client = client;

  final SupabaseClient _client;

  Future getAllTransactions() async {
    return await _client.functions.invoke('getAllTransactions')
    .then((value) {
      return value.data;
    });
  }
}