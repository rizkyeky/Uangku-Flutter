part of '_lib.dart';

Future<void> main() async {
  await runZonedGuarded(() async {

    Log().start('App');

    final binding = WidgetsFlutterBinding.ensureInitialized();
    Sizer.init(binding);

    await dotenv.load(fileName: '.env');

    final prefsService = SharedPreferencesService();
    final prefs = await prefsService.init();
    final encryptedPrefs = prefsService.encryptedPrefs(prefs);

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

    final functionService = FunctionService(
      client: supabaseService.client
    );

    final authProvider = AuthProvider(
      authService: authService,
      databaseService: databaseService,
      functionService: functionService,
      encryptedPrefs: encryptedPrefs
    );
    await authProvider.init();

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => authProvider
        ),
        ChangeNotifierProvider(
          create: (context) => BrightnessProvider(
            binding: binding,
            prefs: prefs,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalizationProvider(
            binding: binding,
            prefs: prefs,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(
            databaseService: databaseService,
            authProvider: authProvider,
          ),
          lazy: true,
        ),
      ],
      child: const App(),
    ));

    FlutterError.onError = (details) => FlutterError.presentError(details);
    ErrorWidget.builder = (details) => ErrorScreen(
      details: details.exception.toString()
    );
    
  }, (error, stack) {
    Log().error(error.toString());
    Log().error(stack.toString());
  },);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) { 
    final brightnessProvider = context.read<BrightnessProvider>();
    final localeProvider = context.watch<LocalizationProvider>();
    
    Log().build('App outside');

    final theme = CupertinoThemeData(
      primaryColor: PrimaryColors.base,
      brightness: brightnessProvider.brightnessForTheme,
      textTheme: TextTheme.textThemeData(context),
    );

    LocalJsonLocalization.delegate.directories = ['assets/i18n'];

    return CupertinoApp.router(
      builder: (context, child) {
        
        final orientation = MediaQuery.of(context).orientation;
        Sizer().setOrientation(orientation);
          
        Log().build('App inside');
        
        return Consumer<BrightnessProvider>(
          builder: (context, brightnessProvider, child) {
            return CupertinoTheme(
              data: theme.copyWith(
                brightness: brightnessProvider.brightnessForTheme,
                textTheme: TextTheme.textThemeData(context),
              ),
              child: child ?? const DecoratedBox(
                decoration: BoxDecoration(
                  color: PrimaryColors.base,
                ),
              ),
            );
          },
          child: child,
        );
      },
      routerDelegate: RoutemasterDelegate(routesBuilder: routeMap),
      routeInformationParser: const RoutemasterParser(),
      
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      locale: localeProvider.localeForApp,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],

      debugShowCheckedModeBanner: false,
      title: 'Uangku',
      theme: theme
    );
  }
}