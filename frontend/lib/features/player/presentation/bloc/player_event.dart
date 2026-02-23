import 'package:equatable/equatable.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object?> get props => [];
}

class PlayerTrackLoaded extends PlayerEvent {
  const PlayerTrackLoaded({required this.trackId});

  final String trackId;

  @override
  List<Object?> get props => [trackId];
}

class PlayerPaused extends PlayerEvent {
  const PlayerPaused();
}

class PlayerResumed extends PlayerEvent {
  const PlayerResumed();
}

class PlayerSeeked extends PlayerEvent {
  const PlayerSeeked({required this.position});

  final Duration position;

  @override
  List<Object?> get props => [position];
}

// Internal event — emitted by the audio engine, never by the UI layer.
// Keeps position ticks inside the BLoC to decouple the audio engine lifecycle.
class PlayerPositionUpdated extends PlayerEvent {
  const PlayerPositionUpdated({required this.position});

  final Duration position;

  @override
  List<Object?> get props => [position];
}
