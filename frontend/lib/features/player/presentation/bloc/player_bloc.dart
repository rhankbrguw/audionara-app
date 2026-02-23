import 'dart:async';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/audio_service.dart';
import '../../domain/entities/track.dart';
import '../../domain/usecases/search_by_vibe_usecase.dart';
import 'player_event.dart';
import 'player_state.dart';

// All playback state decisions are centralised here — widgets emit events
// and render states; they contain zero conditional logic.
class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required this.searchByVibeUseCase,
    AudioService? audioService,
  })  : audioService = audioService ?? AudioService(),
        super(const PlayerInitial()) {
    on<PlayerVibeRequested>(_onVibeRequested);
    on<PlayerPaused>(_onPaused);
    on<PlayerResumed>(_onResumed);
    on<PlayerSeeked>(_onSeeked);
    on<PlayerPositionUpdated>(_onPositionUpdated);
    on<PlayerDurationUpdated>(_onDurationUpdated);
    on<PlayerStateChanged>(_onPlayerStateChanged);
    on<PlayerToggleShuffle>(_onToggleShuffle);
    on<PlayerToggleRepeat>(_onToggleRepeat);

    _positionSubscription = this.audioService.positionStream.listen((pos) {
      add(PlayerPositionUpdated(position: pos));
    });
    _durationSubscription = this.audioService.durationStream.listen((dur) {
      add(PlayerDurationUpdated(duration: dur));
    });
    _playerStateSubscription = this.audioService.playerStateStream.listen((state) {
      add(PlayerStateChanged(state: state));
    });
  }

  final SearchByVibeUseCase searchByVibeUseCase;
  final AudioService audioService;

  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;

  bool _isShuffleEnabled = false;
  bool _isRepeatEnabled = false;

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    audioService.stop();
    return super.close();
  }


  Future<void> _onVibeRequested(
    PlayerVibeRequested event,
    Emitter<PlayerState> emit,
  ) async {
    emit(const PlayerLoading());
    try {
      final tracksList = List<Track>.from(await searchByVibeUseCase(event.vibe));
      if (tracksList.isEmpty) {
        emit(const PlayerError(message: 'No tracks found for this vibe.'));
        return;
      }
      if (_isShuffleEnabled) {
        tracksList.shuffle();
      }
      final track = tracksList.first;
      emit(PlayerPlaying(
        track: track,
        position: Duration.zero,
        duration: Duration.zero,
        currentVibe: event.vibe,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));
      
      // The audio engine will emit real durations to `_durationSubscription`
      // natively over the websocket as soon as the stream is fetched.
      await audioService.play(track.streamUrl);
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  // Audio engine owns pause/resume; BLoC reflects the resulting state only.
  void _onPaused(PlayerPaused event, Emitter<PlayerState> emit) {
    audioService.pause();
  }

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit) {
    audioService.resume();
  }

  void _onSeeked(PlayerSeeked event, Emitter<PlayerState> emit) {
    audioService.seek(event.position);
  }

  void _onDurationUpdated(
    PlayerDurationUpdated event,
    Emitter<PlayerState> emit,
  ) {
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      emit(PlayerPlaying(
        track: current.track,
        position: current.position,
        duration: event.duration,
        currentVibe: current.currentVibe,
        isPlaying: current.isPlaying,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));
    }
  }

  void _onPlayerStateChanged(
    PlayerStateChanged event,
    Emitter<PlayerState> emit,
  ) {
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      final isPlaying = event.state == ap.PlayerState.playing;
      
      Duration newPosition = current.position;
      if (event.state == ap.PlayerState.completed || event.state == ap.PlayerState.stopped) {
        newPosition = Duration.zero;
      }

      emit(PlayerPlaying(
        track: current.track,
        position: newPosition,
        duration: current.duration,
        currentVibe: current.currentVibe,
        isPlaying: isPlaying,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));
    }
  }


  void _onPositionUpdated(
    PlayerPositionUpdated event,
    Emitter<PlayerState> emit,
  ) {
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      
      if (current.duration.inMilliseconds == 0 && event.position.inMilliseconds > 200) {
        audioService.getDuration().then((actualDuration) {
          if (actualDuration != null && actualDuration.inMilliseconds > 0) {
            add(PlayerDurationUpdated(duration: actualDuration));
          }
        });
      }

      emit(PlayerPlaying(
        track: current.track,
        position: event.position,
        duration: current.duration,
        currentVibe: current.currentVibe,
        isPlaying: current.isPlaying,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));
    }
  }

  void _onToggleShuffle(PlayerToggleShuffle event, Emitter<PlayerState> emit) {
    _isShuffleEnabled = !_isShuffleEnabled;
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      emit(PlayerPlaying(
        track: current.track,
        position: current.position,
        duration: current.duration,
        currentVibe: current.currentVibe,
        isPlaying: current.isPlaying,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));
    }
  }

  void _onToggleRepeat(PlayerToggleRepeat event, Emitter<PlayerState> emit) {
    _isRepeatEnabled = !_isRepeatEnabled;
    audioService.setRepeatMode(_isRepeatEnabled);
    if (state is PlayerPlaying) {
      final current = state as PlayerPlaying;
      emit(PlayerPlaying(
        track: current.track,
        position: current.position,
        duration: current.duration,
        currentVibe: current.currentVibe,
        isPlaying: current.isPlaying,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));
    }
  }
}
