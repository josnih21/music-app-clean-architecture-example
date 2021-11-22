import 'package:dartz/dartz.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<Either<Failure, Album>> getAlbum(String? name, String? artist);
}
