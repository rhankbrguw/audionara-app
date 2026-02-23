import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

/// Singleton audio engine wrapper.
///
/// Exposes typed streams and transport controls for the BLoC layer.
/// All I/O exceptions are re-thrown with user-readable messages.
class AudioService {
  AudioService._() {
    _player.onPlayerComplete.listen((_) => _player.stop());
    _player.onLog.listen((_) {});
  }

  static final AudioService _instance = AudioService._();
  factory AudioService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;

  Stream<Duration>    get positionStream    => _player.onPositionChanged;
  Stream<Duration>    get durationStream    => _player.onDurationChanged;
  Stream<PlayerState> get playerStateStream => _player.onPlayerStateChanged;

  Future<void> play(String url) async {
    _currentUrl = url;
    try {
      if (_player.state == PlayerState.playing ||
          _player.state == PlayerState.paused) {
        await _player.stop();
      }
      await _player.play(UrlSource(url));
    } on TimeoutException {
      throw Exception('Network timeout: could not connect to stream.');
    } on SocketException {
      throw Exception('Network error: check internet connection.');
    } catch (e) {
      throw Exception('Playback failed: $e');
    }
  }

  Future<void> pause() => _player.pause();

  Future<void> resume() async {
    final isIdle = _player.state == PlayerState.completed ||
        _player.state == PlayerState.stopped;
    if (isIdle && _currentUrl != null) {
      await _player.play(UrlSource(_currentUrl!));
      return;
    }
    await _player.resume();
  }

  Future<Duration?> getDuration() => _player.getDuration();

  Future<void> setRepeatMode(bool loop) =>
      _player.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.release);

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> stop() => _player.stop();

  Future<void> dispose() => _player.dispose();
}
