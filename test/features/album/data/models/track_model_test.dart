import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/tracks_model.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/track.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final trackModel = [
    TrackModel(name: "Hit the Lights", duration: "257", url: "https://www.last.fm/music/Metallica/_/Hit+the+Lights")
  ];

  test('should be a subclass of Track entity', () async {
    expect(trackModel, isA<List<Track>>());
  });

  group('fromJson', () {
    test('should return valid track model when album is requested', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('album.json'));

      final result = AlbumModel.fromJson(jsonMap).tracks;

      expect(result, equals(trackModel));
    });
  });
}
