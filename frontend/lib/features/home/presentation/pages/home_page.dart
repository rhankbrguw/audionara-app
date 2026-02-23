import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../../user/presentation/bloc/user_state.dart';
import '../../../../features/player/presentation/bloc/player_bloc.dart';
import '../../../../features/player/presentation/bloc/player_state.dart';
import '../../../../features/player/presentation/bloc/player_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good Morning';
    if (hour >= 12 && hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                _buildHeader(context),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                _buildSectionTitle(context, 'Explore Vibes'),
                _buildVibeGrid(context),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                _buildSectionTitle(context, 'Recently Played'),
                _buildRecentlyPlayed(context),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildMiniPlayer(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniPlayer(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerLoading) {
          // Show a loading version
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent),
              ),
            ),
          );
        }

        if (state is! PlayerPlaying) {
          return const SizedBox.shrink(); // Hidden if nothing playing
        }

        final track = state.track;
        final positionMs = state.position.inMilliseconds;
        final durationMs = state.duration.inMilliseconds > 0 ? state.duration.inMilliseconds : 1;
        final progress = (positionMs / durationMs).clamp(0.0, 1.0);

        return RepaintBoundary(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => context.push('/player'),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 1,
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.surface,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: track.coverArt.isNotEmpty
                                ? Image.network(track.coverArt, fit: BoxFit.cover)
                                : const Icon(Icons.music_note, size: 20, color: AppColors.textSecondary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  track.title,
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  track.artist,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              state.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppColors.textPrimary,
                            ),
                            onPressed: () {
                              if (state.isPlaying) {
                                context.read<PlayerBloc>().add(const PlayerPaused());
                              } else {
                                context.read<PlayerBloc>().add(const PlayerResumed());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0, left: 24, right: 24, top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  String displayName = '';
                  if (state is UserLoaded) {
                    displayName = ', ${state.username}';
                  }
                  return Text(
                    '${_getGreeting()}$displayName',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          hintText: 'Search by vibe...',
                          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                          border: InputBorder.none,
                          icon: const Icon(Icons.search, color: AppColors.textSecondary),
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            final playerState = context.read<PlayerBloc>().state;
                            if (playerState is! PlayerPlaying || playerState.currentVibe != value.trim()) {
                              context.read<PlayerBloc>().add(PlayerVibeRequested(vibe: value.trim()));
                            }
                            context.push('/player', extra: value.trim());
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      context.push('/settings');
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: AppColors.onPrimary, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
      ),
    );
  }

  Widget _buildVibeGrid(BuildContext context) {
    final vibes = [
      {'name': 'Synthwave', 'icon': Icons.waves},
      {'name': 'Lofi', 'icon': Icons.coffee},
      {'name': 'Deep Focus', 'icon': Icons.headphones},
      {'name': 'Workout', 'icon': Icons.fitness_center},
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 2.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final vibe = vibes[index];
            return InkWell(
              onTap: () {
                final vibeName = vibe['name'] as String;
                final playerState = context.read<PlayerBloc>().state;
                if (playerState is! PlayerPlaying || playerState.currentVibe != vibeName) {
                  context.read<PlayerBloc>().add(PlayerVibeRequested(vibe: vibeName));
                }
                context.push('/player', extra: vibeName);
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(vibe['icon'] as IconData, color: AppColors.onBackground),
                    const SizedBox(width: 8),
                    Text(
                      vibe['name'] as String,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onBackground,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: vibes.length,
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayed(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  final playerState = context.read<PlayerBloc>().state;
                  if (playerState is! PlayerPlaying || playerState.currentVibe != 'chill') {
                    context.read<PlayerBloc>().add(const PlayerVibeRequested(vibe: 'chill'));
                  }
                  context.push('/player', extra: 'chill');
                },
                child: SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'recent_art_$index',
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.music_note, color: AppColors.textSecondary),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Track ${index + 1}',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
