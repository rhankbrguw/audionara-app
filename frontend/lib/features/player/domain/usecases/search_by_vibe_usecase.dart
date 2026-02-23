import '../entities/track.dart';
import '../repositories/track_repository.dart';

/// Fetches a list of tracks matching the given vibe.
/// Use cases are thin orchestrators — one public input, one output, no UI.
class SearchByVibeUseCase {
  const SearchByVibeUseCase({required this.repository});

  final TrackRepository repository;

  Future<List<Track>> call(String vibe) => repository.searchByVibe(vibe);
}
