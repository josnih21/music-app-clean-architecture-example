import 'package:equatable/equatable.dart';

class Track extends Equatable {
  final String name;
  final String url;
  final String duration;

  Track({
    this.name,
    this.url,
    this.duration,
  });

  @override
  List<Object> get props => [name, url, duration];
}
