import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/image_model.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/image.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final imageModel = [
    ImageModel(
      text: "https://lastfm.freetls.fastly.net/i/u/34s/0e79f0c8fbf341178601367a4a12a890.png",
      size: 'small',
    )
  ];

  test('should be a subclass of Image entity', () async {
    expect(imageModel, isA<List<ImageEntity>>());
  });

  group('fromJson', () {
    test('should return valid image model when album is requested', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('album.json'));

      final result = AlbumModel.fromJson(jsonMap).images;

      expect(result, equals(imageModel));
    });
  });
}
