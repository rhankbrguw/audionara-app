import '../entities/track.dart';
import '../repositories/track_repository.dart';

/// Fetches a single track by ID.
/// Use cases are thin orchestrators — one public input, one output, no UI.
class GetTrackUseCase {
  const GetTrackUseCase({required this.repository});

  final TrackRepository repository;

  Future<Track> call(String trackId) => repository.findById(trackId);
}
