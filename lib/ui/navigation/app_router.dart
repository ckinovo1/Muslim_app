import 'package:go_router/go_router.dart';
import 'package:muslim_app/ui/navigation/main_screen.dart';
import 'package:muslim_app/factories/screen_factory.dart';

class AppRouter {
  late final GoRouter router;
  final ScreenFactory _factory;

  AppRouter({required ScreenFactory screenFactory}) : _factory = screenFactory {
    router = GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) => MainScreen(child: child),
          routes: [
            GoRoute(
              path: '/prayer',
              builder: (_, __) => _factory.makePrayerScreen(),
            ),
            GoRoute(
              path: '/service',
              builder: (_, __) => _factory.makeServiceScreen(),
            ),
            GoRoute(
              path: '/settings',
              builder: (_, __) => _factory.makeSettingsScreen(),
            ),
            GoRoute(
              path: '/azkar',
              builder: (_, __) => _factory.makeDummyScreen("Азкары"),
            ),
            GoRoute(
              path: '/tasbeeh',
              builder: (_, __) => _factory.makeDummyScreen("Тасбих"),
            ),
          ],
        ),
      ],
      initialLocation: '/prayer',
    );
  }
}
