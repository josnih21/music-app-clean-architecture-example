import 'dart:convert';

import 'package:music_app_clean_architecture/core/error/exception.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AlbumLocalDataSource {
  Future<AlbumModel> getLastAlbum();

  ///Throws [CacheException] if no cache present
  Future<void> cacheAlbum(AlbumModel albumToCache);
}

const CACHED_ALBUM = 'CACHED_ALBUM';

class AlbumLocalDataSourceImpl implements AlbumLocalDataSource {
  final SharedPreferences sharedPreferences;

  AlbumLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<void> cacheAlbum(AlbumModel albumToCache) {
    return sharedPreferences.setString(CACHED_ALBUM, json.encode(albumToCache.toJson()));
  }

  @override
  Future<AlbumModel> getLastAlbum() {
    final jsonString = sharedPreferences.getString(CACHED_ALBUM);
    if (jsonString != null) {
      return Future.value(AlbumModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
