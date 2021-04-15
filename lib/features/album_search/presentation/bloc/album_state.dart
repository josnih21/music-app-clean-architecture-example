part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class ALbumBlocLoadInProgress extends AlbumState {}

class AlbumBlocLoadFinished extends AlbumState {
  final Album album;

  AlbumBlocLoadFinished(this.album);

  @override
  List<Object> get props => [album];
}

class AlbumBlocLoadFailed extends AlbumState {
  final String message;

  AlbumBlocLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
