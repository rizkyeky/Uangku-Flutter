// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:crypto/crypto.dart';
// import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:uangku/_lib.dart';
import 'package:uangku/utils/_utils.dart';

void main() async {

  await dotenv.load(fileName: '.env');

  final urlEncoded = dotenv.env['SUPABASE_URL_ENCODED']!;
  final apikeyEncoded = dotenv.env['SUPABASE_APIKEY_ENCODED']!;

  final url = decryptSecretKey(SecretKey.supabaseUrlKey, urlEncoded);
  final apiKey = decryptSecretKey(SecretKey.supabaseApiKeyKey, apikeyEncoded);

  print(url);
  print(apiKey);

  // final plainText = 'https://lgxdqrfjcrugbqjdoxlg.supabase.co';
  // final key = Key.fromUtf8('Sk&%fOLjelr6BftTXj7vL60Y!*u3YGC@');
  // final iv = IV.fromLength(16);

  // final encrypter = Encrypter(AES(key));

  // final encrypted = encrypter.encrypt(plainText, iv: iv);
  // print(encrypted.base64);
}
