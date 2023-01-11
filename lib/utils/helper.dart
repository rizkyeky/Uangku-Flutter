part of _utils;

String decryptSecretKey(String secretKey, String encoded) {
  final key = encr.Key.fromUtf8(secretKey);
  final iv = encr.IV.fromLength(16);

  final encrypter = encr.Encrypter(encr.AES(key));
  final encrypted = encr.Encrypted.from64(encoded);

  return encrypter.decrypt(encrypted, iv: iv);
}

Color resolveDynamicColor(BuildContext context, {
  required Color color, 
  required Color darkColor
}) => CupertinoDynamicColor.resolve(
    CupertinoDynamicColor.withBrightness(
      color: color, 
      darkColor: darkColor,
    ), context
  );