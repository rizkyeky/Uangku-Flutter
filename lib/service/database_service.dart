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
    await _client.from(table).insert(data)
    .then((value) {
      Log().service('insert $table');
      return value;
    }, onError: (error, stackTrace) {
      Log().error(error.toString());
      throw error!;
    });
  }

  Future fetch({
    required String table,
    required String columns,
    String? eqColumn,
    dynamic eqValue, 
  }) async {
    final select = _client.from(table).select(columns);
    if (eqColumn != null && eqValue != null) {
      await select.eq(eqColumn, eqValue)
      .then((value) {
        Log().service('insert $table');
        return value;
      }, onError: (error, stackTrace) {
        Log().error(error.toString());
        throw error!;
      });
    } else {
      await select
      .then((value) {
        Log().service('insert $table');
        return value;
      }, onError: (error, stackTrace) {
        Log().error(error.toString());
        throw error!;
      });
    }
  }

  Future delete({
    required String table,
  }) async {
    await _client.from(table).delete()
    .then((value) {
      Log().service('delete $table');
      return value;
    })
    .onError((error, stackTrace) {
      Log().error(error.toString());
      throw error!;
    });
  }

  Future update({
    required String table,
    required Map<String, dynamic> data
  }) async {
    await _client.from(table).update(data)
    .then((value) {
      Log().service('update $table');
      return value;
    })
    .onError((error, stackTrace) {
      Log().error(error.toString());
      throw error!;
    });
  }
}