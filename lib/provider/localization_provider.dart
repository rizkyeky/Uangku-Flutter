part of _provider;

class LocalizationProvider with ChangeNotifier {

  Locale? _currLocale;
  Locale _platformLocale;

  final Locale _defaultLocale = const Locale('id');

  final SharedPreferences _prefs;

  LocalizationProvider({
    required WidgetsBinding binding,
    required SharedPreferences prefs,
  }) :
    _platformLocale = binding.window.locale,
    _prefs = prefs 
  {
    final code = _loadLocale();
    if (code != null) {
      _currLocale = Locale(code);
    }
  }
  
  Locale get localeForApp => _currLocale ?? _defaultLocale;

  set localeFromPlatform(Locale locale) {
    _platformLocale = locale;
  }

  void changeLangTo() {
    if (_currLocale == null) {
      _currLocale = _defaultLocale;
    } else if (_currLocale?.languageCode == 'en') {
      _currLocale = const Locale('id');
    } else {
      _currLocale = const Locale('en');
    }
    _saveLocale(_currLocale);
    notifyListeners();
  }

  static const String _key = 'LOCALESTATUS';

  Future<void> _saveLocale(Locale? value) async {
    if (value != null) {
      await _prefs.setString(_key, value.languageCode);
    } else if (_prefs.containsKey(_key)) {
      await _prefs.remove(_key);
    }
  }

  String? _loadLocale() {
    return _prefs.getString(_key);
  }
}