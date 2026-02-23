import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// UI shell only — all playback state is projected from PlayerBloc above
// this widget via BlocBuilder (added in a subsequent phase).
class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Now Playing',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
