import 'package:flutter/material.dart';
import 'package:music_app_clean_architecture/features/album_search/presentation/pages/album_search_page.dart';
import 'injection_container.dart' as dependecyInjector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependecyInjector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: AlbumSearchPage(),
      theme: ThemeData.dark(),
    );
  }
}
