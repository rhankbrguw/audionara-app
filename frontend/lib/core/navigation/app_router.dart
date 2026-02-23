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
      builder: (context, state) {
        // Since PlayerBloc is global, we can optionally dispatch an initial vibe
        // if one is provided via route extra, and if we aren't already playing one.
        final initialVibe = state.extra as String?;
        if (initialVibe != null) {
          // Fire and forget - but only if we want to force playback on nav.
          // Usually better to let the UI dispatch this when tapped, but we'll 
          // leave it as-is if navigation explicitly passes a vibe.
        }
        return const PlayerPage();
      },
    ),
  ],
);
