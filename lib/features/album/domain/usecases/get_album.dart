import 'package:dartz/dartz.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:meta/meta.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album/domain/repositories/album_repository.dart';

class GetAlbum {
  final AlbumRepository albumRepository;

  GetAlbum(this.albumRepository);

  Future<Either<Failure, Album>> execute({
    @required String name,
    @required String artist,
  }) async {
    return await albumRepository.getAlbum(name, artist);
  }
}
