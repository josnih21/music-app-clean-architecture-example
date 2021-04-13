import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_app_clean_architecture/core/error/exception.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:music_app_clean_architecture/core/network/network_info.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_local_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_remote_data_source.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/repositories/album_repository_impl.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';

class MockRemoteDataSource extends Mock implements AlbumRemoteDataSource {}

class MockLocalDataSource extends Mock implements AlbumLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AlbumRepositoryImpl albumRepositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    albumRepositoryImpl = AlbumRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('get album', () {
    final name = "Kill 'Em All";
    final artist = 'Metallica';
    final url = 'www.dummy.com';
    final listeners = '11';
    final albumModel = AlbumModel(artist: artist, name: name, images: [], tracks: [], url: url, listeners: listeners);
    final Album album = albumModel;

    test('should check if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      albumRepositoryImpl.getAlbum(name, artist);
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test('should return remote data when the call to remote data source is successfull', () async {
        when(mockRemoteDataSource.getAlbum(any, any)).thenAnswer((_) async => albumModel);

        final result = await albumRepositoryImpl.getAlbum(name, artist);
        verify(mockRemoteDataSource.getAlbum(name, artist));
        expect(result, equals(Right(album)));
      });

      test('should cache data locally when the call to remote data source is successfull', () async {
        when(mockRemoteDataSource.getAlbum(any, any)).thenAnswer((_) async => albumModel);

        final result = await albumRepositoryImpl.getAlbum(name, artist);
        verify(mockRemoteDataSource.getAlbum(name, artist));
        verify(mockLocalDataSource.cacheAlbum(albumModel));
        expect(result, equals(Right(album)));
      });

      test('should return ServerFailure  when the call to remote data source is unsuccessfull', () async {
        when(mockRemoteDataSource.getAlbum(any, any)).thenThrow(ServerException());

        final result = await albumRepositoryImpl.getAlbum(name, artist);
        verify(mockRemoteDataSource.getAlbum(name, artist));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('should return last local cache data when the cache data is present', () async {
        when(mockLocalDataSource.getLastAlbum()).thenAnswer((_) async => albumModel);

        final result = await albumRepositoryImpl.getAlbum(name, artist);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastAlbum());
        expect(result, equals(Right(album)));
      });
      test('should return CacheFailure when there is no cache data present', () async {
        when(mockLocalDataSource.getLastAlbum()).thenThrow(CacheException());

        final result = await albumRepositoryImpl.getAlbum(name, artist);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastAlbum());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
