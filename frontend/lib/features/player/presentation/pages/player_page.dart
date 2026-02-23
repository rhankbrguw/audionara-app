import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../bloc/player_bloc.dart';
import '../bloc/player_event.dart';
import '../bloc/player_state.dart';
import '../../../playlist/presentation/bloc/playlist_bloc.dart';
import '../../../playlist/presentation/bloc/playlist_event.dart';
import '../../../playlist/presentation/bloc/playlist_state.dart';
import '../../../playlist/domain/entities/playlist_item.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is PlayerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppStrings.playbackError}${state.message}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(AppStrings.nowPlaying),
          centerTitle: true,
        ),
        body: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state is PlayerLoading || state is PlayerInitial) {
              return _buildShimmerLoading();
            }

            if (state is PlayerPlaying) {
              return _buildPlayerUI(context, state);
            }

            if (state is PlayerError) {
              return _buildErrorState(context);
            }

            return const Center(child: Text(AppStrings.initializing));
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.surfaceVariant.withValues(alpha: 0.2),
            highlightColor: AppColors.surface,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Shimmer.fromColors(
            baseColor: AppColors.surfaceVariant.withValues(alpha: 0.2),
            highlightColor: AppColors.surface,
            child: Container(
              width: 200,
              height: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: AppColors.surfaceVariant.withValues(alpha: 0.2),
            highlightColor: AppColors.surface,
            child: Container(
              width: 150,
              height: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.failedToLoadTrack,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.redAccent,
                ),
          ),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () {
              context
                  .read<PlayerBloc>()
                  .add(const PlayerVibeRequested(vibe: 'synthwave'));
            },
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerUI(BuildContext context, PlayerPlaying state) {
    final track = state.track;

    return SafeArea(
      top: false,
      bottom: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.4,
                      maxWidth: constraints.maxHeight * 0.4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: track.coverArt.isNotEmpty
                            ? Image.network(
                                track.coverArt,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildFallbackArt(),
                              )
                            : _buildFallbackArt(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.title,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              track.artist,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<PlaylistBloc, PlaylistState>(
                        listener: (context, playlistState) {},
                        builder: (context, playlistState) {
                          bool isSaved = false;
                          if (playlistState is PlaylistInitial) {
                            context.read<PlaylistBloc>().add(
                              CheckFavoriteStatus(trackId: track.id),
                            );
                          } else if (playlistState is PlaylistTrackStatus &&
                              playlistState.trackId == track.id) {
                            isSaved = playlistState.isSaved;
                          }

                          return Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  isSaved ? Icons.favorite : Icons.favorite_border,
                                  color: isSaved ? AppColors.primary : AppColors.textSecondary,
                                  size: 32,
                                ),
                                onPressed: () {
                                  final item = PlaylistItem()
                                    ..trackId = track.id
                                    ..title = track.title
                                    ..artist = track.artist
                                    ..coverArt = track.coverArt
                                    ..streamUrl = track.streamUrl
                                    ..addedAt = DateTime.now();

                                  context.read<PlaylistBloc>().add(
                                    ToggleFavoriteStatus(item: item),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  _PlayerSlider(state: state),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(state.position),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      Text(
                        _formatDuration(state.duration),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 42,
                        icon: const Icon(Icons.skip_previous, color: AppColors.onBackground),
                        onPressed: () => context
                            .read<PlayerBloc>()
                            .add(PlayerVibeRequested(vibe: state.currentVibe)),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        iconSize: 72,
                        icon: Icon(
                          state.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: AppColors.onBackground,
                        ),
                        onPressed: () {
                          if (state.isPlaying) {
                            context.read<PlayerBloc>().add(const PlayerPaused());
                          } else {
                            context.read<PlayerBloc>().add(const PlayerResumed());
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        iconSize: 42,
                        icon: const Icon(Icons.skip_next, color: AppColors.onBackground),
                        onPressed: () => context
                            .read<PlayerBloc>()
                            .add(PlayerVibeRequested(vibe: state.currentVibe)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.shuffle, color: state.isShuffleEnabled ? AppColors.primary : AppColors.textSecondary),
                        onPressed: () => context.read<PlayerBloc>().add(const PlayerToggleShuffle()),
                      ),
                      IconButton(
                        icon: Icon(Icons.repeat, color: state.isRepeatEnabled ? AppColors.primary : AppColors.textSecondary),
                        onPressed: () => context.read<PlayerBloc>().add(const PlayerToggleRepeat()),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: AppColors.textSecondary),
                        onPressed: () => _showSettingsBottomSheet(context, track),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        },
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context, dynamic track) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.playlist_add, color: AppColors.textPrimary),
                title: Text('Add to Playlist', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  final item = PlaylistItem()
                    ..trackId = track.id
                    ..title = track.title
                    ..artist = track.artist
                    ..coverArt = track.coverArt
                    ..streamUrl = track.streamUrl
                    ..addedAt = DateTime.now();

                  context.read<PlaylistBloc>().add(
                    ToggleFavoriteStatus(item: item),
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Toggled in Playlist')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.textPrimary),
                title: Text('View Artist', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Artist route for ${track.artist} coming soon')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.high_quality, color: AppColors.textPrimary),
                title: Text('Audio Quality (Current: 128kbps)', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Audio quality options coming soon')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFallbackArt() {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: Icon(
          Icons.music_note,
          size: 80,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class _PlayerSlider extends StatelessWidget {
  const _PlayerSlider({required this.state});

  final PlayerPlaying state;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppColors.accent,
        inactiveTrackColor: AppColors.surfaceVariant,
        thumbColor: AppColors.onBackground,
        trackHeight: 2.0,
        trackShape: const _CustomTrackShape(),
        thumbShape:
            const RoundSliderThumbShape(enabledThumbRadius: 6.0, elevation: 0),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        min: 0.0,
        max: state.duration.inMilliseconds > 0
            ? state.duration.inMilliseconds.toDouble()
            : 1.0,
        value: state.position.inMilliseconds.toDouble().clamp(
            0.0,
            state.duration.inMilliseconds > 0
                ? state.duration.inMilliseconds.toDouble()
                : 1.0),
        onChanged: (value) {
          context.read<PlayerBloc>().add(
                PlayerSeeked(position: Duration(milliseconds: value.toInt())),
              );
        },
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  const _CustomTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 2.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
