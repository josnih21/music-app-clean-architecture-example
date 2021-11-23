import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app_clean_architecture/core/error/failures.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/usecases/get_album.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbumUseCase getAlbumUseCase;

  AlbumBloc({required GetAlbumUseCase getAlbum})
      // ignore: unnecessary_null_comparison
      : assert(getAlbum != null),
        getAlbumUseCase = getAlbum,
        super(AlbumInitial());

  @override
  Stream<AlbumState> mapEventToState(
    AlbumEvent event,
  ) async* {
    yield AlbumInitial();
    if (event is GetAlbum) {
      yield ALbumBlocLoadInProgress();
      final failureOrAlbum = await getAlbumUseCase(Params(artist: event.artist, name: event.album));
      yield failureOrAlbum.fold(
          (failure) => AlbumBlocLoadFailed(failure is ServerFailure ? 'No album found' : 'No album found in cache'),
          (album) => AlbumBlocLoadFinished(album));
    }
  }
}
