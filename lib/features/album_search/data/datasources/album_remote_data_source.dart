import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_clean_architecture/core/error/exception.dart';
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import 'package:http/http.dart' as http;
import '../../../../apikey.dart';

abstract class AlbumRemoteDataSource {
  /// Will [ServerException] for all error codes
  Future<AlbumModel> getAlbum(String name, String artist);
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  final http.Client client;
  AlbumRemoteDataSourceImpl({this.client});

  @override
  Future<AlbumModel> getAlbum(String name, String artist) async {
    final response = await client.get(
        'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=$apiKey&artist=$artist&album=$name&format=json');
    if (response.statusCode == 200 && !response.body.contains('Album not found')) {
      return AlbumModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
