import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:music_app_clean_architecture/core/usecases/usecase.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/repositories/album_repository.dart';

class GetAlbum implements UseCase<Album, Params> {
  final AlbumRepository albumRepository;

  GetAlbum(this.albumRepository);

  @override
  Future<Either<Failure, Album>> call({Params params}) async {
    return await albumRepository.getAlbum(params.name, params.artist);
  }
}

class Params extends Equatable {
  final String name;
  final String artist;

  Params({this.name, this.artist}) : super([name, artist]);
}
