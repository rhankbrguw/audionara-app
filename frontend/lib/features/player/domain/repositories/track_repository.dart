import '../entities/track.dart';

/// Abstract contract for track data access.
/// Concrete implementations live in the data layer and are injected at runtime.
abstract class TrackRepository {
  Future<Track> findById(String id);
  Future<List<Track>> findAll();
  Future<List<Track>> searchByVibe(String vibe);
}
