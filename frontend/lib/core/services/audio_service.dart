import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

/// A singleton wrapper around the AudioPlayer instance.
/// Exposes streams and playback controls for the BLoC to consume.
class AudioService {
  AudioService._privateConstructor() {
    _initStreams();
  }

  static final AudioService _instance = AudioService._privateConstructor();

  factory AudioService() {
    return _instance;
  }

  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;

  Stream<Duration> get positionStream => _player.onPositionChanged;
  Stream<Duration> get durationStream => _player.onDurationChanged;
  Stream<PlayerState> get playerStateStream => _player.onPlayerStateChanged;

  Future<void> play(String url) async {
    _currentUrl = url;
    try {
      if (_player.state == PlayerState.playing || _player.state == PlayerState.paused) {
        await _player.stop();
      }
      await _player.play(UrlSource(url));
    } on TimeoutException {
      throw Exception('Network timeout: Could not connect to the stream.');
    } on SocketException {
      throw Exception('Network error: Ensure you have an internet connection.');
    } catch (e) {
      throw Exception('Failed to play stream: $e');
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    if (_player.state == PlayerState.completed || _player.state == PlayerState.stopped) {
      if (_currentUrl != null) {
        await _player.play(UrlSource(_currentUrl!));
        return;
      }
    }
    await _player.resume();
  }

  Future<Duration?> getDuration() async {
    return await _player.getDuration();
  }

  Future<void> setRepeatMode(bool isRepeat) async {
    await _player.setReleaseMode(isRepeat ? ReleaseMode.loop : ReleaseMode.release);
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }

  void _initStreams() {
    _player.onPlayerComplete.listen((_) async {
      // Force stop to trigger onPlayerStateChanged(PlayerState.stopped) for BLoC sync
      await _player.stop();
    });
    
    _player.onLog.listen((log) {
      // In a real ERP setup, ship to remote logger here.
    });
  }
}
