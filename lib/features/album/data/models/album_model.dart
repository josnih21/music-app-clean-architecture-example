import 'package:music_app_clean_architecture/features/album/data/models/image_model.dart';
import 'package:music_app_clean_architecture/features/album/data/models/tracks_model.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/album.dart';

class AlbumModel extends Album {
  AlbumModel({
    String name,
    String artist,
    String url,
    List<ImageModel> images,
    String listeners,
    List<TrackModel> tracks,
  }) : super(name: name, artist: artist, url: url, images: images, listeners: listeners, tracks: tracks);

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
        name: json['album']['name'],
        artist: json['album']['artist'],
        url: json['album']['url'],
        images: List<ImageModel>.from(json['album']['image'].map((data) => ImageModel.fromJson(data))),
        tracks: List<TrackModel>.from(json['album']["tracks"]["track"].map((x) => TrackModel.fromJson(x))),
        listeners: json['album']['listeners']);
  }
}
