import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';

abstract class AlbumRemoteDataSource {
  /// TODO-ADD ENDPOINT INFO
  /// Will [ServerException] for all error codes
  Future<AlbumModel> getAlbum(String name, String artist);
}
