import 'package:equatable/equatable.dart';
import '../../domain/entities/track.dart';

// ---------------------------------------------------------------------------
// States
// ---------------------------------------------------------------------------

/// Base class for all PlayerBloc states.
abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

/// The player has not been initialised yet.
class PlayerInitial extends PlayerState {
  const PlayerInitial();
}

/// A track is being buffered / loaded.
class PlayerLoading extends PlayerState {
  const PlayerLoading();
}

/// A track is currently playing.
class PlayerPlaying extends PlayerState {
  const PlayerPlaying({
    required this.track,
    required this.position,
    required this.duration,
  });

  final Track track;
  final Duration position;
  final Duration duration;

  @override
  List<Object?> get props => [track, position, duration];
}

/// An unrecoverable error occurred during playback.
class PlayerError extends PlayerState {
  const PlayerError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
