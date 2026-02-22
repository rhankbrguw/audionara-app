/// Dart mirror of the Go Track domain entity.
/// This PODO (Plain Old Dart Object) is the canonical representation of
/// a track throughout the Flutter app. No framework dependencies.
class Track {
  const Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.streamUrl,
    required this.coverArt,
  });

  final String id;
  final String title;
  final String artist;
  final String streamUrl;
  final String coverArt;

  @override
  String toString() =>
      'Track(id: $id, title: $title, artist: $artist)';
}
