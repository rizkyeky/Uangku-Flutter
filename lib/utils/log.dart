part of _utils;

class Log {

  factory Log() => _singleton;
  const Log._constructor();
  static const Log _singleton = Log._constructor();

  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: false,
      printEmojis: true,
      printTime: false
    ),
  );
  static final _loggerError = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: false,
      printEmojis: true,
      printTime: false
    ),
  );
  Logger get print => _logger;
  void start(String name) => _logger.i('🌟 start $name');
  void build(String name) => _logger.i('🛠️ build $name');
  void service(String name) => _logger.i('🌐 service $name');
  void success(String name) => _logger.i('✅ success $name');
  void error(String name) => _loggerError.e(name);
}