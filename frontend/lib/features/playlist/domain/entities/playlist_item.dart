import 'package:isar/isar.dart';

part 'playlist_item.g.dart';

@collection
class PlaylistItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String trackId;

  late String title;
  late String artist;
  late String streamUrl;
  late String coverArt;
  
  @Index()
  late DateTime addedAt;
}
