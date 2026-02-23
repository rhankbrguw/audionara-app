import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/playlist/domain/entities/playlist_item.dart';

class IsarDatabase {
  static late Isar _instance;

  static Isar get instance => _instance;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [PlaylistItemSchema],
      directory: dir.path,
    );
  }
}
