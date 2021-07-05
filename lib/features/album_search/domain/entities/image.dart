import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final text;
  final size;

  ImageEntity({
    this.text,
    this.size,
  });
//add random line
  @override
  List<Object> get props => [text, size];
}
