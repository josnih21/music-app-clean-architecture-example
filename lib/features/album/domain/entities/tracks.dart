import 'package:equatable/equatable.dart';

class Tracks extends Equatable {
  final List<Track> track;

  Tracks({this.track}) : super([track]);
}

class Track extends Equatable {
  final String name;
  final String url;
  final String duration;

  Track(
    this.name,
    this.url,
    this.duration,
  ) : super([name, url, duration]);
}
