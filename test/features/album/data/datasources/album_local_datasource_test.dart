import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app_clean_architecture/core/error/exception.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_local_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/image_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/tracks_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  AlbumLocalDataSourceImpl? albumLocalDataSourceImpl;
  MockSharedPreferences? mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    albumLocalDataSourceImpl = AlbumLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastAlbum', () {
    final albumModel = AlbumModel.fromJson(json.decode(fixture('album_cached.json')));
    test(('should return album from sharedPreferences when there is one in the cache'), () async {
      when(mockSharedPreferences?.getString("any")).thenReturn(fixture('album_cached.json'));

      final result = await albumLocalDataSourceImpl?.getLastAlbum();

      verify(mockSharedPreferences?.getString(CACHED_ALBUM));
      expect(result, equals(albumModel));
    });
    test(('should return error when there is no info in the cache'), () async {
      when(mockSharedPreferences?.getString("hello")).thenReturn(null);

      expect(() => albumLocalDataSourceImpl?.getLastAlbum(), throwsA(isA<CacheException>()));
    });
  });
  group('cacheAlbum', () {
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
              duration: 257, name: 'Hit the Lights', url: 'https://www.last.fm/music/Metallica/_/Hit+the+Lights'),
        ]);
    test(('should call SharedPreferences to cache data'), () async {
      albumLocalDataSourceImpl?.cacheAlbum(albumModel);
      final expectedJsonString = json.encode(albumModel.toJson());
      verify(mockSharedPreferences?.setString(CACHED_ALBUM, expectedJsonString));
    });
  });
}
