import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'album_bloc_test.mocks.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/usecases/get_album.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/bloc/album_bloc.dart';

@GenerateMocks([GetAlbumUseCase])
void main() {
  AlbumBloc? albumBloc;
  final mockGetAlbumUseCase = MockGetAlbumUseCase();
  setUp(() {
    albumBloc = AlbumBloc(
      getAlbum: mockGetAlbumUseCase,
    );
  });
  test(('initialState should be AlbumInitial'), () {
    expect(albumBloc!.state, equals(AlbumInitial()));
  });

  group(('GetAlbum'), () {
    final albumName = "Kill 'Em All";
    final artist = "Metallica";
    final album = Album(
      artist: artist,
      name: albumName,
      images: [],
      listeners: '11',
      tracks: [],
      url: 'dummy.com',
    );

    test(('should emit [ALbumBlocLoadInProgress and AlbumBlocLoadFinished] when data is gotten succesfully'), () async {
      when(mockGetAlbumUseCase(Params(name:"Kill 'Em All", artist: "Metallica"))).thenAnswer((_) async => Right(album));

      final expect = [
        AlbumInitial(),
        ALbumBlocLoadInProgress(),
        AlbumBlocLoadFinished(album),
      ];

      expectLater(albumBloc?.stream, emitsInOrder(expect));
      albumBloc!.add(GetAlbum(albumName, artist));
    });
    test(('should emit [AlbumBlocLoadInProgress and AlbumBlocLoadFailed] when data not gotten succesfully'), () async {
      when(mockGetAlbumUseCase(Params(name:"Kill 'Em All", artist: "Metallica"))).thenAnswer((_) async => Left(ServerFailure()));

      final expect = [
        AlbumInitial(),
        ALbumBlocLoadInProgress(),
        AlbumBlocLoadFailed('No album found'),
      ];

      expectLater(albumBloc?.stream, emitsInOrder(expect));
      albumBloc!.add(GetAlbum(albumName, artist));
    });
    test(('should emit [AlbumBlocLoadInProgress and AlbumBlocLoadFailed] when data not gotten succesfully'), () async {
      when(mockGetAlbumUseCase(Params(name:"Kill 'Em All", artist: "Metallica"))).thenAnswer((_) async => Left(CacheFailure()));

      final expect = [
        AlbumInitial(),
        ALbumBlocLoadInProgress(),
        AlbumBlocLoadFailed('No album found in cache'),
      ];

      expectLater(albumBloc?.stream, emitsInOrder(expect));
      albumBloc!.add(GetAlbum(albumName, artist));
    });
  });
}
