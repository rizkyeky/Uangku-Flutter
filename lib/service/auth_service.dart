part of _service;

class AuthService {

  AuthService({
    required SupabaseClient client,
  }) :
  _client = client;

  final SupabaseClient _client;
  
  Session? currentSession() => _client.auth.currentSession;

  Future<AuthResponse> recoverSession(String session) async {
    try {
      final response = await _client.auth.recoverSession(session);
      return response;
    } on AuthException catch (e, t) {
      Log().error(e.message);
      Log().error(t.toString());
      throw e.message;
    } catch (e, t) {
      Log().error(e.toString());
      Log().error(t.toString());
      if (e.toString().contains('Failed host lookup')) {
        throw 'Error Internet Connection';
      } else {
        rethrow;
      }
    }
  }

  Future<AuthResponse> signUp(String email, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      Log().service('SignUp');
      return response;
    } on AuthException catch (e, t) {
      Log().error(e.message);
      Log().error(t.toString());
      throw e.message;
    } catch (e, t) {
      Log().error(e.toString());
      Log().error(t.toString());
      if (e.toString().contains('Failed host lookup')) {
        throw 'Error Internet Connection';
      } else {
        rethrow;
      }
    }
  }
  
  Future<AuthResponse> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      Log().service('SignIn');
      return response;
    } on AuthException catch (e, t) {
      Log().error(e.message);
      Log().error(t.toString());
      throw e.message;
    } catch (e, t) {
      Log().error(e.toString());
      Log().error(t.toString());
      if (e.toString().contains('Failed host lookup')) {
        throw 'Error Internet Connection';
      } else {
        rethrow;
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      Log().service('SignOut');
    } on AuthException catch (e, t) {
      Log().error(e.message);
      Log().error(t.toString());
      throw e.message;
    } catch (e, t) {
      Log().error(e.toString());
      Log().error(t.toString());
      if (e.toString().contains('Failed host lookup')) {
        throw 'Error Internet Connection';
      } else {
        rethrow;
      }
    }
  }
}