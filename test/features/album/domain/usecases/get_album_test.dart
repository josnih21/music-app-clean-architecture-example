import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/image.dart';
import 'package:music_app_clean_architecture/features/album/domain/entities/tracks.dart';
import 'package:music_app_clean_architecture/features/album/domain/repositories/album_repository.dart';
import 'package:music_app_clean_architecture/features/album/domain/usecases/get_album.dart';

class MockAlbumRepository extends Mock implements AlbumRepository {}

void main() {
  GetAlbum usecase;
  MockAlbumRepository mockAlbumRespository;

  setUp(() {
    mockAlbumRespository = MockAlbumRepository();
    usecase = GetAlbum(mockAlbumRespository);
  });

  final name = 'Kill ' 'Em All';
  final artist = 'Metallica';
  final url = 'www.dummy.com';
  final images = [
    Image(text: 'random.jpg', size: 'small'),
    Image(text: 'random2.jpg', size: 'big'),
  ];
  final listeners = '1111';
  final tracks = [
    Track(name: 'The four horsemen', url: 'www.dummy.com', duration: '3:50'),
    Track(name: 'Seek and Destroy', url: 'www.dummy.com', duration: '3:30'),
  ];

  final album = Album(name: name, artist: artist, images: images, listeners: listeners, tracks: tracks, url: url);

  test('should get album from the repository', () async {
    when(mockAlbumRespository.getAlbum(any, any)).thenAnswer((_) async => Right(album));

    final result = await usecase(params: Params(name: name, artist: artist));

    expect(result, Right(album));
    verify(mockAlbumRespository.getAlbum(name, artist));
    verifyNoMoreInteractions(mockAlbumRespository);
  });
}
