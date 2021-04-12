import 'package:equatable/equatable.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/image.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/tracks.dart';

class Album extends Equatable {
  final String name;
  final String artist;
  final String url;
  final List<Image> images;
  final String listeners;
  final Tracks tracks;

  Album({
    this.name,
    this.artist,
    this.url,
    this.images,
    this.listeners,
    this.tracks,
  }) : super([name, artist, url, images, listeners, tracks]);
}
