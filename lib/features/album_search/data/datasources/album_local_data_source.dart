import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';

abstract class AlbumLocalDataSource {
  Future<AlbumModel> getLastAlbum();

  ///Throws [CacheException] if no cache present
  Future<void> cacheAlbum(AlbumModel albumToCache);
}
