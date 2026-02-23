import 'package:isar/isar.dart';
import '../../../../core/database/isar_database.dart';
import '../../domain/entities/playlist_item.dart';

class PlaylistRepository {
  Isar get _db => IsarDatabase.instance;

  Future<void> addTrack(PlaylistItem item) async {
    await _db.writeTxn(() async {
      await _db.playlistItems.put(item);
    });
  }

  Future<void> removeTrack(String trackId) async {
    await _db.writeTxn(() async {
      await _db.playlistItems.filter().trackIdEqualTo(trackId).deleteAll();
    });
  }

  Future<bool> isTrackSaved(String trackId) async {
    final count = await _db.playlistItems.filter().trackIdEqualTo(trackId).count();
    return count > 0;
  }

  Future<List<PlaylistItem>> getAllSavedTracks() async {
    return _db.playlistItems.where().sortByAddedAtDesc().findAll();
  }
}
