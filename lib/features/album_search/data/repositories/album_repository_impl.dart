import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:music_app_clean_architecture/core/error/exception.dart';
import 'package:music_app_clean_architecture/core/network/network_info.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_local_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_remote_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource? remoteDataSource;
  final AlbumLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  AlbumRepositoryImpl({
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, Album>> getAlbum(String? name, String? artist) async {
    var result = await networkInfo!.isConnected;
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi ) {
      try {
        final remoteAlbum = await remoteDataSource!.getAlbum(name, artist);
        localDataSource!.cacheAlbum(remoteAlbum);
        return Right(remoteAlbum);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAlbum = await localDataSource!.getLastAlbum();
        return Right(localAlbum);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
