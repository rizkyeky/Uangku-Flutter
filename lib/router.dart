part of '_lib.dart';

RouteMap routeMap(BuildContext context) {
  final isLogged = context.watch<AuthProvider>().isLogged;

  final loggedOutRouteMap = RouteMap(
    onUnknownRoute: (path) => const Redirect('/'),
    routes: {
      '/': (route) => const CupertinoPage(
        key: ValueKey('SignInPage'),
        child: SignInPage()
      ),
      '/signup': (route) => const CupertinoPage(
        key: ValueKey('SignUpPage'),
        child: SignUpPage()
      ),
    }
  );

  return !isLogged ? loggedOutRouteMap : RouteMap(
    onUnknownRoute: (path) => const Redirect('/'),
    routes: {
      '/': (route) => const CupertinoTabPage(
        child:  TabPage(),
        paths: ['/home', '/trans', '/profile'],
      ),
      '/home': (route) => const CupertinoPage(
        child: HomePage()
      ),
      '/trans': (route) => const CupertinoPage(
        child: TransPage()
      ),
      '/profile': (route) => const CupertinoPage(
        child: ProfilePage()
      )
    }
  );
}
