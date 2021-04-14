import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final text;
  final size;

  Image({
    this.text,
    this.size,
  });

  @override
  List<Object> get props => [text, size];
}
