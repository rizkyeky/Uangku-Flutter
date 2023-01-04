part of _provider;

class BrightnessProvider with ChangeNotifier {

  Brightness? _currBrightness;
  Brightness _platformBrightness;

  final SharedPreferences _prefs;

  BrightnessProvider({
    required WidgetsBinding binding, 
    required SharedPreferences prefs
  }) : 
    _platformBrightness = binding.window.platformBrightness,
    _prefs = prefs
  {    
    final index = _getBrightness();
    if (index != null) {
      _currBrightness = Brightness.values[index];
    }
  }

  Brightness? get brightnessForTheme => _currBrightness;

  set brightnessFromPlatform(Brightness brightness) {
    _platformBrightness = brightness;
  }

  bool isBrightnessSystem() => _currBrightness == _platformBrightness;

  void setToDark() {
    if (_currBrightness != Brightness.dark) {
      _currBrightness = Brightness.dark;
      _setBrightness(_currBrightness);
      notifyListeners();
    }
  }

  void setToLight() {
    if (_currBrightness != Brightness.light) {
      _currBrightness = Brightness.light;
      _setBrightness(_currBrightness);
      notifyListeners();
    }
  }

  void setToDefaultSystem() {
    if (_currBrightness != null) {
      _currBrightness = null;
      _setBrightness(_currBrightness);
      notifyListeners();
    }
  }

  static const String _key = 'BRIGHTNESSSTATUS';

  Future<void> _setBrightness(Brightness? value) async {
    if (value != null) {
      await _prefs.setInt(_key, value.index);
    } else if (_prefs.containsKey(_key)) {
      await _prefs.remove(_key);
    }
  }

  int? _getBrightness() {
    return _prefs.getInt(_key);
  }
}