import 'package:music_app_clean_architecture/features/album_search/domain/entities/track.dart';

class TrackModel extends Track {
  TrackModel({
    String? name,
    String? url,
    int? duration,
  }) : super(name: name, url: url, duration: duration);

  factory TrackModel.fromJson(Map<String, dynamic> json) => TrackModel(
        name: json["name"],
        url: json["url"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'duration': duration,
    };
  }
}
