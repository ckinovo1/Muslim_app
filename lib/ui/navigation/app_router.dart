import 'package:go_router/go_router.dart';
import 'package:muslim_app/ui/navigation/main_screen.dart';
import 'package:muslim_app/factories/screen_factory.dart';

class AppRouter {
  late final GoRouter router;
  final ScreenFactory _factory = ScreenFactory();

  AppRouter() {
    router = GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return MainScreen(child: child);
          },
          routes: [
            GoRoute(
              path: '/prayer',
              builder: (_, _) => _factory.makePrayerScreen(),
            ),
            GoRoute(
              path: '/service',
              builder: (_, _) => _factory.makeServiceScreen(),
            ),
            GoRoute(
              path: '/settings',
              builder: (_, _) => _factory.makeSettingsScreen(),
            ),
            GoRoute(
              path: '/azkar',
              builder: (_, __) => _factory.makeDummyScreen("Азкары"),
            ),
            GoRoute(
              path: '/tasbeeh',
              builder: (_, __) => _factory.makeDummyScreen("Тасбих"),
            ),
            GoRoute(
              path: '/qibla',
              builder: (_, __) => _factory.makeDummyScreen("Кибла"),
            ),

            GoRoute(
              path: '/sunnah',
              builder: (_, __) => _factory.makeDummyScreen("Сунна намаз"),
            ),
            GoRoute(
              path: '/calendar',
              builder: (_, __) => _factory.makeDummyScreen("Календарь"),
            ),
          ],
        ),
      ],
      initialLocation: '/service',
    );
  }
}
