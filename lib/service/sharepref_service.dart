part of _service;

class SharedPreferencesService {

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  EncryptedSharedPreferences encryptedPrefs(SharedPreferences prefs) 
    => EncryptedSharedPreferences(
      prefs: prefs
    );
}