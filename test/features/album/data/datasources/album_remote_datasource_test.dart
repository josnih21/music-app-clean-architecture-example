import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app_clean_architecture/core/error/exception.dart';
import 'package:music_app_clean_architecture/features/album_search/data/datasources/album_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:music_app_clean_architecture/features/album_search/data/models/album_model.dart';
import '../../../../../lib/apikey.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  AlbumRemoteDataSourceImpl albumRemoteDataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    albumRemoteDataSourceImpl = AlbumRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpHttp(int statusCode) {
    when(mockHttpClient.get(any)).thenAnswer((_) async => http.Response(fixture("album.json"), statusCode));
  }

  group(('GetAlbum'), () {
    final albumName = "Kill 'Em All";
    final artist = 'Metallica';
    final albumModel = AlbumModel.fromJson(json.decode(fixture("album.json")));
    test(
      ('should perfom GET request on a URL with and album name and artist in the endpoint'),
      () async {
        setUpHttp(200);
        albumRemoteDataSourceImpl.getAlbum(albumName, artist);

        verify(mockHttpClient.get(
          'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=$apiKey&artist=$artist&album=$albumName&format=json',
        ));
      },
    );
    test(
      ('should return album model when response is 200'),
      () async {
        setUpHttp(200);
        final result = await albumRemoteDataSourceImpl.getAlbum(albumName, artist);

        expect(result, equals(albumModel));
      },
    );
    test(
      ('should throw ServeException when response code is 404 or other'),
      () async {
        setUpHttp(404);
        expect(() => albumRemoteDataSourceImpl.getAlbum(albumName, artist), throwsA(isA<ServerException>()));
      },
    );
  });
}
