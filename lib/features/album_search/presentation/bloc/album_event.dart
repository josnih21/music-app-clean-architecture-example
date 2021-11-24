part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object?> get props => [];
}

class GetAlbum extends AlbumEvent {
  final String? album;
  final String? artist;

  GetAlbum(this.album, this.artist);

  @override
  List<Object?> get props => [album, artist];
}
