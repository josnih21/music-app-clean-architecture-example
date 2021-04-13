import 'package:dartz/dartz_unsafe.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/image_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/tracks_model.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';

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

  Map<String, Map<String, dynamic>> toJson() {
    return {
      'album': {
        'name': name,
        'artist': artist,
        'url': url,
        'image': List<dynamic>.from(images.map((image) => image)),
        'listeners': listeners,
        'tracks': List<dynamic>.from(tracks.map((track) => track)),
      }
    };
  }
}
