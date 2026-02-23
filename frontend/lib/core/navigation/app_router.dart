import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/player/presentation/pages/player_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

GoRouter buildAppRouter(SharedPreferences prefs) => GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      builder: (context, state) => const PlayerPage(),
    ),
  ],
);
