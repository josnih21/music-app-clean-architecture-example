import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';

class AlbumDisplay extends StatelessWidget {
  final Album album;

  const AlbumDisplay({Key key, this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Text(album.name),
            Text(album.listeners),
            Image(
                image: CachedNetworkImageProvider(album.images.firstWhere((image) => image.size == 'extralarge').text)),
            Center(
              child: SingleChildScrollView(
                child: Text(album.artist),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: album.tracks.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, dynamic index) {
                return ListTile(
                  title: Text(album.tracks[index].name),
                  subtitle: Text(album.tracks[index].duration),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
