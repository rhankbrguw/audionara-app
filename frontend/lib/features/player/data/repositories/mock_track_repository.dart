import '../../domain/entities/track.dart';
import '../../domain/repositories/track_repository.dart';

/// In-memory stub implementation of [TrackRepository].
///
/// Used exclusively in development/routing setup. Replace with a real
/// HTTP/database implementation once the backend is available.
///
/// MUST NOT be used outside of the DI wiring layer (app_router.dart or
/// the DI module). Never import this into a widget or BLoC directly.
class MockTrackRepository implements TrackRepository {
  final List<Track> _mockCatalogue = [
      Track(
        id: '1',
        title: 'Mock Track 1',
        artist: 'AudioNara',
        streamUrl: 'https://example.com/stream/1',
        coverArt: 'https://example.com/cover/1.jpg',
      ),
  ];

  @override
  Future<Track> findById(String id) async {
    return Track(
      id: id,
      title: 'Mock Track',
      artist: 'AudioNara',
      streamUrl: 'https://example.com/stream',
      coverArt: 'https://example.com/cover.jpg',
    );
  }

  @override
  Future<List<Track>> searchByVibe(String vibe) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockCatalogue
        .where((t) => t.title.toLowerCase().contains(vibe.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Track>> findAll() async {
    return _mockCatalogue;
  }
}
