import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/image_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/tracks_model.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final albumModel = AlbumModel(
      name: "Kill 'Em All",
      artist: 'Metallica',
      url: "www.dummy.com",
      images: [
        ImageModel(
            size: 'small', text: 'https://lastfm.freetls.fastly.net/i/u/34s/0e79f0c8fbf341178601367a4a12a890.png')
      ],
      listeners: '11',
      tracks: [
        TrackModel(
            duration: '257', name: 'Hit the Lights', url: 'https://www.last.fm/music/Metallica/_/Hit+the+Lights'),
      ]);

  test('should be a subclass of Album entity', () async {
    expect(albumModel, isA<Album>());
  });

  group('fromJson', () {
    test('should return valid model when album is requested', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('album.json'));

      final result = AlbumModel.fromJson(jsonMap);

      expect(result, equals(albumModel));
    });
  });

  group('toJson', () {
    test('should return a JSON containing proper data', () async {
      final result = albumModel.toJson();
      final expectedMap = {
        'album': {
          "name": "Kill 'Em All",
          "artist": "Metallica",
          "url": "www.dummy.com",
          "image": [
            ImageModel(
                size: 'small', text: 'https://lastfm.freetls.fastly.net/i/u/34s/0e79f0c8fbf341178601367a4a12a890.png')
          ],
          "listeners": "11",
          "tracks": [
            TrackModel(
                duration: '257', name: 'Hit the Lights', url: 'https://www.last.fm/music/Metallica/_/Hit+the+Lights'),
          ],
        }
      };
      expect(result, expectedMap);
    });
  });
}
