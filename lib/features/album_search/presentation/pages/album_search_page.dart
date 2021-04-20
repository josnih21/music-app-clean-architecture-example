import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_clean_architecture/features/album_search/domain/entities/album.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/bloc/album_bloc.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/pages/album_details_page.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/widgets/loading.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/widgets/message_display.dart';
import 'package:music_app_clean_architecture/injection_container.dart';

class AlbumSearchPage extends StatefulWidget {
  @override
  _AlbumSearchPageState createState() => _AlbumSearchPageState();
}

class _AlbumSearchPageState extends State<AlbumSearchPage> {
  final textControllerAlbum = TextEditingController();
  final textControllerArtist = TextEditingController();
  AlbumBloc albumBloc = serviceLocator<AlbumBloc>();
  var albumName;
  var artistName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<AlbumBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => albumBloc,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                BlocBuilder<AlbumBloc, AlbumState>(
                  builder: (context, state) {
                    if (state is AlbumInitial) {
                      return MessageDisplay(
                        message: 'Fill fields to find an album',
                      );
                    } else if (state is ALbumBlocLoadInProgress) {
                      return LoadingWidget();
                    } else if (state is AlbumBlocLoadFinished) {
                      navigateToAlbumDetails(state.album);
                      return Container();
                    } else if (state is AlbumBlocLoadFailed) {
                      return MessageDisplay(
                        message: state.message,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: textControllerArtist,
                      onChanged: (value) => artistName = value,
                      decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Type artist name'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: textControllerAlbum,
                      onChanged: (value) {
                        albumName = value;
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Type album name'),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RaisedButton(
                        onPressed: dispachAlbumSearch,
                        color: Colors.orange,
                        child: Text('Search album'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  void dispachAlbumSearch() {
    textControllerAlbum.clear();
    textControllerArtist.clear();

    albumBloc.add(GetAlbum(albumName, artistName));
  }

  void navigateToAlbumDetails(Album album) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlbumDetailsPage(
            album: album,
          ),
        ),
      );
    });
  }
}
