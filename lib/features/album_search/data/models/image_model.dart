import 'package:music_app_clean_architecture/features/album_search/domain/entities/image.dart';

class ImageModel extends Image {
  ImageModel({
    String text,
    String size,
  }) : super(text: text, size: size);

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        text: json["#text"],
        size: json["size"],
      );
}