part of _provider;

class TransactionProvider extends ChangeNotifier {

  TransactionProvider({
    required DatabaseService databaseService,
    required AuthProvider authProvider,
  }) :
  _databaseService = databaseService,
  _authProvider = authProvider;

  final DatabaseService _databaseService;
  final AuthProvider _authProvider;

  Future addTransaction() async {
    return await _databaseService.insert(
      table: 'transaction',
      data: {
        'user_id': _authProvider.user?.id,
        'name': name,
        'desc': desc,
        'amount': amount,
        'type': type,
      }
    ).then((value) {
      update();
      return value;
    });
  }

  Future fetchAllTransaction() async {
    return await _databaseService.fetch(
      table: 'transaction',
      eqColumn: 'user_id',
      eqValue: _authProvider.user?.id,
    ).then((value) {
      update();
      return value;
    });
  }

  String? name, desc;
  int? amount;
  String type = 'input';

  void clearInput() {
    name = null;
    desc = null;
    amount = null;
    type = 'input';
  }

  int? _total;

  Future<int?> calculateTotal() async {
    if (_total != null) {
      return _total;
    }
    else {
      return await _databaseService.fetch(
        table: 'transaction',
        columns: 'amount, type',
        eqColumn: 'user_id',
        eqValue: _authProvider.user?.id,
      )
      .then((value) {
        if (value is List) {
          int total = 0;
          for (final element in value) {
            if (element['type'] == 'input') {
              total += (element['amount'] as int?) ?? 0;
            }
            else if (element['type'] == 'output') {
              total -= (element['amount'] as int?) ?? 0;
            }
          }
          return _total = total;
        }
        return null;
      });
    }
  }

  void update() {
    _total = null;
    notifyListeners();
  }
}