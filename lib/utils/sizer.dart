part of _utils;

class Sizer {
  
  factory Sizer() => _instance;

  Sizer._constructor();
  static final Sizer _instance = Sizer._constructor();
  
  late final double devicePixelRatio;
  late Size designSize;
  late Size physicalSize;
  late Size deviceSize;

  factory Sizer.init(WidgetsBinding binding, [
    Size designSize = const Size(360, 690),
  ]) {
    _instance.devicePixelRatio = binding.window.devicePixelRatio;
    _instance.physicalSize = binding.window.physicalSize;
    _instance.designSize = designSize;
    _instance.deviceSize = _instance.physicalSize / _instance.devicePixelRatio;
    return _instance;
  } 

  late Orientation _orientation;
  bool _isInitOrientation = false;
  void setOrientation(Orientation value) {
    if (!_isInitOrientation) {
      _isInitOrientation = true;
      _orientation = value;
    }
    if (_orientation != value) {
      _orientation = value;
      designSize = designSize.flipped;
      physicalSize = physicalSize.flipped;
      deviceSize = deviceSize.flipped;
    }
  }
  Orientation get orientation => _orientation;

  double get scale => (deviceSize.width*deviceSize.height)/(designSize.width*designSize.height);
  double get scaleW => deviceSize.width/designSize.width;
  double get scaleH => deviceSize.height/designSize.height;
}

extension ScreenSizeEx on num {
  double get w => this + (this/10 * Sizer().scaleW);
  double get h => this + (this/10 * Sizer().scaleH);
  double get s => this + (this/20 * Sizer().scale);
}