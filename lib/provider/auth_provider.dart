part of _provider;

class AuthProvider extends ChangeNotifier {

  AuthProvider({
    required AuthService authService,
    required DatabaseService databaseService,
    required FunctionService functionService,
    required EncryptedSharedPreferences encryptedPrefs,
  }) : 
  _authService = authService, 
  _databaseService = databaseService, 
  _functionService = functionService, 
  _encryptedPrefs = encryptedPrefs;

  final AuthService _authService;
  final DatabaseService _databaseService;
  final FunctionService _functionService;
  final EncryptedSharedPreferences _encryptedPrefs;

  bool get isLogged => _authService.currentSession() != null;
  Session? get session => _authService.currentSession();
  User? get user => _authService.currentSession()?.user;

  Session? _session;
  Profile? _profile;

  Future<void> init() async {
    final persistSession = await getPersistSession();
    if (persistSession != null) {
      await _authService.recoverSession(persistSession)
      .then((value) {
        _session = value.session;
      }, onError: (e, t) async {
        _session = null;
        _profile = null;
        await removePersistedSession();
      });
    }
  }

  Future<Profile?> getProfile() async {
    if (_profile != null && _profile?.user?.id == user?.id) {
      return _profile;
    } else {
      return await _databaseService.fetch(
        table: 'profile', 
        eqColumn: 'id',
        eqValue: user?.id,
      )
      .then((value) {
        if (value is List && value.isNotEmpty) {
          return _profile = Profile.fromJsonAndUser(value[0], user);
        }
        return null;
      });
    }
  }

  Future<void> signIn(String email, String password) async {
    await _authService.signIn(email, password)
    .then((value) async {
      _session = value.session;
      if (_session != null) {
        await savePersistSession();
        notifyListeners();
      }
    });
  }

  Future<void> signUp({
    required String email, 
    required String password,
    required String name,
  }) async {
    await _authService.signUp(email, password)
    .then((value) async {
      _session = value.session;
      if (_session != null) {
        await _databaseService.insert(
          table: 'profile', 
          data: {
            'id': _session!.user.id,
            'name': name,
          }
        );
        await savePersistSession();
        notifyListeners();
      }
    });
  }

  Future<void> signOut() async {
    await _authService.signOut()
    .then((_) async {
      _session = null;
      _profile = null;
      await removePersistedSession();
      notifyListeners();
    });
  }

  static const String _key = SecretKey.sessionKey;

  Future<void> savePersistSession() async {
    if (_session != null) {
      await _encryptedPrefs.setString(_key, _session!.persistSessionString);
    }
  }

  Future<String?> getPersistSession() async {
    var val = await _encryptedPrefs.getString(_key);
    val = val.trim();
    return (val.isEmpty) ? null : val;
  }

  Future<void> removePersistedSession() async {
    await _encryptedPrefs.remove(_key);
  }
}