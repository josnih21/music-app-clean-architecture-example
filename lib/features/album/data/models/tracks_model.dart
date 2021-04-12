import 'package:music_app_clean_architecture/features/album/domain/entities/tracks.dart';

class TracksModel extends Tracks {
  TracksModel({List<TrackModel> track}) : super(track: track);

  factory TracksModel.fromJson(Map<String, dynamic> json) => TracksModel(
        track: List<TrackModel>.from(json["track"].map((x) => TrackModel.fromJson(x))),
      );
}

class TrackModel extends Track {
  TrackModel({
    String name,
    String url,
    String duration,
  }) : super(name: name, url: url, duration: duration);

  factory TrackModel.fromJson(Map<String, dynamic> json) => TrackModel(
        name: json["name"],
        url: json["url"],
        duration: json["duration"],
      );
}
