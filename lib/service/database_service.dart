part of _service;

class DatabaseService {

  DatabaseService({
    required SupabaseClient client
  }) :
  _client = client;

  final SupabaseClient _client;

  Future insert({
    required String table,
    required Map<String, dynamic> data
  }) async {
    return await _client.from(table).insert(data)
    .then((value) {
      Log().service('insert $table');
      return value;
    }, onError: (error, t) {
      Log().error(error.toString());
      Log().error(t.toString());
      throw error!;
    });
  }

  Future fetch({
    required String table,
    String? columns,
    String? eqColumn,
    dynamic eqValue, 
  }) async {
    final select = _client.from(table).select(columns ?? '*');
    if (eqColumn != null && eqValue != null) {
      return await select.eq(eqColumn, eqValue)
      .then((value) {
        Log().service('fetch with eq $table');
        return value;
      }, onError: (error, t) {
        Log().error(error.toString());
        Log().error(t.toString());
        throw error!;
      });
    } else {
      return await select
      .then((value) {
        Log().service('fetch $table');
        return value;
      }, onError: (error, t) {
        Log().error(error.toString());
        Log().error(t.toString());
        throw error!;
      });
    }
  }

  Future delete({
    required String table,
  }) async {
    return await _client.from(table).delete()
    .then((value) {
      Log().service('delete $table');
      return value;
    })
    .onError((error, t) {
      Log().error(error.toString());
      Log().error(t.toString());
      throw error!;
    });
  }

  Future update({
    required String table,
    required Map<String, dynamic> data
  }) async {
    return await _client.from(table).update(data)
    .then((value) {
      Log().service('update $table');
      return value;
    })
    .onError((error, t) {
      Log().error(error.toString());
      Log().error(t.toString());
      throw error!;
    });
  }
}