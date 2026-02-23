// Fail-fast DI wiring: each route owns its BLoC scope to bound memory
// on mobile — no leaked providers between navigations.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/player/presentation/pages/player_page.dart';
import '../../features/player/presentation/bloc/player_bloc.dart';
import '../../features/player/domain/usecases/get_track_usecase.dart';
import '../../features/player/data/repositories/mock_track_repository.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      // Scoped to /player to release BLoC resources on back-navigation.
      builder: (context, state) => BlocProvider(
        create: (context) => PlayerBloc(
          getTrackUseCase: GetTrackUseCase(
            repository: MockTrackRepository(),
          ),
        ),
        child: const PlayerPage(),
      ),
    ),
  ],
);
