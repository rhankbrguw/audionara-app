import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/database/isar_database.dart';
import 'features/player/presentation/bloc/player_bloc.dart';
import 'features/playlist/presentation/bloc/playlist_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/bloc/user_event.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/playlist/data/repositories/playlist_repository.dart';
import 'features/player/domain/usecases/search_by_vibe_usecase.dart';
import 'features/player/data/repositories/api_track_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatabase.initialize();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(AudioNaraApp(prefs: prefs));
}

class AudioNaraApp extends StatelessWidget {
  const AudioNaraApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()..add(const LoadUser())),
        BlocProvider(create: (context) => SettingsBloc(prefs: prefs)..add(LoadSettings())),
        BlocProvider(
          create: (context) => PlayerBloc(
            searchByVibeUseCase: SearchByVibeUseCase(repository: ApiTrackRepository(prefs: prefs)),
          ),
        ),
        BlocProvider(create: (context) => PlaylistBloc(repository: PlaylistRepository())),
      ],
      child: MaterialApp.router(
        title: 'AudioNara',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: buildAppRouter(prefs),
      ),
    );
  }
}
