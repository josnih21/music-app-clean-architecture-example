import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';

class AlbumDisplay extends StatelessWidget {
  final Album album;

  const AlbumDisplay({Key key, this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200.0),
            child: Image(
              image: CachedNetworkImageProvider(
                album.getExtraLargeImageUrl(),
                maxHeight: 250,
                maxWidth: 250,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              album.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  album.artist,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
              album.wiki != null
                  ? IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () => _setModalSheet(context),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      color: Colors.orange,
                    )
                  : Container(),
            ],
          ),
          ListView.builder(
            itemCount: album.tracks.length,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, dynamic index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  title: Text(album.tracks[index].name),
                  subtitle: Text(album.tracks[index].durationInMinutesAndSeconds()),
                  trailing: Icon(Icons.headset),
                  tileColor: Colors.orange.withOpacity(0.5),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _setModalSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Html(
              data: album.wiki,
            ),
          ),
        );
      },
    );
  }
}
