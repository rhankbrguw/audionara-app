import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_track_usecase.dart';
import 'player_event.dart';
import 'player_state.dart';

// All playback state decisions are centralised here — widgets emit events
// and render states; they contain zero conditional logic.
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required this.getTrackUseCase}) : super(const PlayerInitial()) {
    on<PlayerTrackLoaded>(_onTrackLoaded);
    on<PlayerPaused>(_onPaused);
    on<PlayerResumed>(_onResumed);
    on<PlayerSeeked>(_onSeeked);
    on<PlayerPositionUpdated>(_onPositionUpdated);
  }

  final GetTrackUseCase getTrackUseCase;

  Future<void> _onTrackLoaded(
    PlayerTrackLoaded event,
    Emitter<PlayerState> emit,
  ) async {
    emit(const PlayerLoading());
    try {
      final track = await getTrackUseCase(event.trackId);
      emit(PlayerPlaying(
        track: track,
        position: Duration.zero,
        duration: Duration.zero,
      ));
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  // Audio engine owns pause/resume; BLoC reflects the resulting state only.
  void _onPaused(PlayerPaused event, Emitter<PlayerState> emit) {}

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit) {}

  void _onSeeked(PlayerSeeked event, Emitter<PlayerState> emit) {
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      emit(PlayerPlaying(
        track: current.track,
        position: event.position,
        duration: current.duration,
      ));
    }
  }

  void _onPositionUpdated(
    PlayerPositionUpdated event,
    Emitter<PlayerState> emit,
  ) {
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      emit(PlayerPlaying(
        track: current.track,
        position: event.position,
        duration: current.duration,
      ));
    }
  }
}
