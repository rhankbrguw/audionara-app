import 'package:equatable/equatable.dart';

// ---------------------------------------------------------------------------
// Events
// ---------------------------------------------------------------------------

/// Base class for all PlayerBloc events.
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

/// Request to load and start playing a track by ID.
class PlayerTrackLoaded extends PlayerEvent {
  const PlayerTrackLoaded({required this.trackId});

  final String trackId;

  @override
  List<Object?> get props => [trackId];
}

/// User paused the current track.
class PlayerPaused extends PlayerEvent {
  const PlayerPaused();
}

/// User resumed the current track.
class PlayerResumed extends PlayerEvent {
  const PlayerResumed();
}

/// User seeked to a new position.
class PlayerSeeked extends PlayerEvent {
  const PlayerSeeked({required this.position});

  final Duration position;

  @override
  List<Object?> get props => [position];
}

/// Internal event: playback position updated (fired by audio engine).
class PlayerPositionUpdated extends PlayerEvent {
  const PlayerPositionUpdated({required this.position});

  final Duration position;

  @override
  List<Object?> get props => [position];
}
