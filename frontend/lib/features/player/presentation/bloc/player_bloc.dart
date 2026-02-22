import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_track_usecase.dart';
import 'player_event.dart';
import 'player_state.dart';

/// PlayerBloc orchestrates audio playback state.
///
/// All business decisions live here — widgets only dispatch events and
/// render states. Zero logic permitted in UI layer.
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
        duration: Duration.zero, // will be set once audio engine reports it
      ));
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  void _onPaused(PlayerPaused event, Emitter<PlayerState> emit) {
    // Pausing is handled by the audio service; BLoC reflects state only.
    // Implementation hook — extend when audio engine is wired.
  }

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit) {
    // Resuming is handled by the audio service; BLoC reflects state only.
  }

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
