import 'package:equatable/equatable.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/image.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/track.dart';

class Album extends Equatable {
  final String? name;
  final String? artist;
  final String? url;
  final List<ImageEntity>? images;
  final String? listeners;
  final List<Track>? tracks;
  final String? wiki;

  Album({
    this.name,
    this.artist,
    this.url,
    this.images,
    this.listeners,
    this.tracks,
    this.wiki,
  });

  @override
  List<Object?> get props => [name, artist, url, images, listeners, tracks];

  String? getExtraLargeImageUrl() {
    return images!.firstWhere((image) => image.size == 'extralarge').text;
  }
}
