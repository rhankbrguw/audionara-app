import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/track.dart';
import '../../domain/repositories/track_repository.dart';

class ApiTrackRepository implements TrackRepository {
  ApiTrackRepository({
    http.Client? client,
    String? baseUrl,
    SharedPreferences? prefs,
  })  : _client = client ?? http.Client(),
        _prefs = prefs,
        _baseUrl = baseUrl ??
            const String.fromEnvironment(
              'API_BASE_URL',
              defaultValue: 'http://10.0.2.2:8080',
            ) {
    log('ApiTrackRepository init: $_baseUrl');
  }

  final http.Client _client;
  final String _baseUrl;
  final SharedPreferences? _prefs;

  @override
  Future<Track> findById(String id) async {
    final results = await _searchByVibe(id);
    if (results.isEmpty) throw Exception('Track not found: $id');
    return results.first;
  }

  @override
  Future<List<Track>> findAll() =>
      throw UnimplementedError('Use searchByVibe for catalogue queries.');

  @override
  Future<List<Track>> searchByVibe(String vibe) => _searchByVibe(vibe);

  Future<List<Track>> _searchByVibe(String vibe) async {
    final requestedKbps = _prefs?.getInt('stream_quality') ?? 128;
    final limit = requestedKbps == 64 ? 20 : (requestedKbps == 256 ? 50 : 25);

    final response = await _client
        .get(Uri.parse(
            '$_baseUrl/api/v1/tracks/search?term=${Uri.encodeComponent(vibe)}&limit=$limit&quality=$requestedKbps'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(body['error'] ?? 'Unknown API error');
    }

    final filterExplicit = _prefs?.getBool('filter_explicit') ?? true;
    final responseBody = response.body;

    return Isolate.run(() {
      final body = jsonDecode(responseBody) as Map<String, dynamic>;
      final data = body['data'] as List<dynamic>? ?? [];

      return data
          .cast<Map<String, dynamic>>()
          .where((t) => !(filterExplicit && t['trackExplicitness'] == 'explicit'))
          .map(_trackFromJson)
          .toList(growable: false);
    });
  }

  static Track _trackFromJson(Map<String, dynamic> json) => Track(
        id: json['id'] as String,
        title: json['title'] as String,
        artist: json['artist'] as String,
        streamUrl: json['stream_url'] as String,
        coverArt: json['cover_art'] as String,
      );
}
