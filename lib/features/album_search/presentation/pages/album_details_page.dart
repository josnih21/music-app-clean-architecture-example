import 'package:flutter/material.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/widgets/album_display.dart';

class AlbumDetailsPage extends StatefulWidget {
  final Album album;
  AlbumDetailsPage({this.album});

  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: AlbumDisplay(album: widget.album),
    );
  }
}
