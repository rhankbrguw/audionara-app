import 'dart:async';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/audio_service.dart';
import '../../domain/entities/track.dart';
import '../../domain/usecases/search_by_vibe_usecase.dart';
import 'player_event.dart';
import 'player_state.dart';

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

    _positionSubscription = this.audioService.positionStream.listen(
      (pos) => add(PlayerPositionUpdated(position: pos)),
    );
    _durationSubscription = this.audioService.durationStream.listen(
      (dur) => add(PlayerDurationUpdated(duration: dur)),
    );
    _playerStateSubscription = this.audioService.playerStateStream.listen(
      (s) => add(PlayerStateChanged(state: s)),
    );
  }

  final SearchByVibeUseCase searchByVibeUseCase;
  final AudioService audioService;

  late final StreamSubscription _positionSubscription;
  late final StreamSubscription _durationSubscription;
  late final StreamSubscription _playerStateSubscription;

  bool _isShuffleEnabled = false;
  bool _isRepeatEnabled = false;

  static const _positionDebounceMs = 500;

  @override
  Future<void> close() async {
    await Future.wait([
      _positionSubscription.cancel(),
      _durationSubscription.cancel(),
      _playerStateSubscription.cancel(),
    ]);
    await audioService.stop();
    return super.close();
  }

  Future<void> _onVibeRequested(
    PlayerVibeRequested event,
    Emitter<PlayerState> emit,
  ) async {
    emit(const PlayerLoading());
    try {
      final tracks = List<Track>.from(await searchByVibeUseCase(event.vibe))
        ..shuffle();

      if (tracks.isEmpty) {
        emit(const PlayerError(message: 'No tracks found for this vibe.'));
        return;
      }

      final track = tracks.first;

      emit(PlayerPlaying(
        track: track,
        position: Duration.zero,
        duration: Duration.zero,
        currentVibe: event.vibe,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      ));

      await audioService.play(track.streamUrl);
    } catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }

  void _onPaused(PlayerPaused event, Emitter<PlayerState> emit) =>
      audioService.pause();

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit) =>
      audioService.resume();

  void _onSeeked(PlayerSeeked event, Emitter<PlayerState> emit) =>
      audioService.seek(event.position);

  void _onDurationUpdated(
    PlayerDurationUpdated event,
    Emitter<PlayerState> emit,
  ) {
    if (state is! PlayerPlaying) return;
    final current = state as PlayerPlaying;
    emit(_withMeta(current, duration: event.duration));
  }

  void _onPlayerStateChanged(
    PlayerStateChanged event,
    Emitter<PlayerState> emit,
  ) {
    if (state is! PlayerPlaying) return;
    final current = state as PlayerPlaying;

    final isPlaying = event.state == ap.PlayerState.playing;
    final isTerminal = event.state == ap.PlayerState.completed ||
        event.state == ap.PlayerState.stopped;

    emit(_withMeta(
      current,
      position: isTerminal ? Duration.zero : current.position,
      isPlaying: isPlaying,
    ));
  }

  void _onPositionUpdated(
    PlayerPositionUpdated event,
    Emitter<PlayerState> emit,
  ) {
    if (state is! PlayerPlaying) return;
    final current = state as PlayerPlaying;

    if (current.duration.inMilliseconds == 0 &&
        event.position.inMilliseconds > 200) {
      audioService.getDuration().then((d) {
        if (d != null && d.inMilliseconds > 0) {
          add(PlayerDurationUpdated(duration: d));
        }
      });
    }

    final delta =
        (event.position.inMilliseconds - current.position.inMilliseconds).abs();
    if (delta < _positionDebounceMs) return;

    emit(_withMeta(current, position: event.position));
  }

  void _onToggleShuffle(
    PlayerToggleShuffle event,
    Emitter<PlayerState> emit,
  ) {
    _isShuffleEnabled = !_isShuffleEnabled;
    _emitModeUpdate(emit);
  }

  void _onToggleRepeat(
    PlayerToggleRepeat event,
    Emitter<PlayerState> emit,
  ) {
    _isRepeatEnabled = !_isRepeatEnabled;
    audioService.setRepeatMode(_isRepeatEnabled);
    _emitModeUpdate(emit);
  }

  void _emitModeUpdate(Emitter<PlayerState> emit) {
    if (state is! PlayerPlaying) return;
    emit(_withMeta(state as PlayerPlaying));
  }

  PlayerPlaying _withMeta(
    PlayerPlaying current, {
    Duration? position,
    Duration? duration,
    bool? isPlaying,
  }) =>
      PlayerPlaying(
        track: current.track,
        position: position ?? current.position,
        duration: duration ?? current.duration,
        currentVibe: current.currentVibe,
        isPlaying: isPlaying ?? current.isPlaying,
        isShuffleEnabled: _isShuffleEnabled,
        isRepeatEnabled: _isRepeatEnabled,
      );
}
