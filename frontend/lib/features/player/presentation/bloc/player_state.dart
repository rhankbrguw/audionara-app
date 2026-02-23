import 'package:equatable/equatable.dart';
import '../../domain/entities/track.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial();
}

class PlayerLoading extends PlayerState {
  const PlayerLoading();
}

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

// Error state carries the message as a value — widgets project it into UI,
// no raw exception objects cross the BLoC boundary.
class PlayerError extends PlayerState {
  const PlayerError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
