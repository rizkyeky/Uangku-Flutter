// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uangku/provider/_provider.dart';
import 'package:uangku/service/_service.dart';

import 'package:uangku/utils/_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  
  await dotenv.load(fileName: '.env');
  final urlEncoded = dotenv.env['SUPABASE_URL_ENCODED']!;
  final apiKeyEncoded = dotenv.env['SUPABASE_API_KEY_ENCODED']!;

  final supabaseService = SupabaseService(
    url: decryptSecretKey(SecretKey.supabaseUrlKey, urlEncoded),
    apiKey: decryptSecretKey(SecretKey.supabaseApiKeyKey, apiKeyEncoded)
  );

  final authService = AuthService(
    client: supabaseService.client
  );

  final databaseService = DatabaseService(
    client: supabaseService.client
  );

  final authRes = await authService.signIn('eky@gmail.com', '123456');

  await supabaseService.client.from('transaction').select().then((value) {
    print(value);
  });

  final data = await databaseService.fetch(table: 'transaction');
  print(data);
}
