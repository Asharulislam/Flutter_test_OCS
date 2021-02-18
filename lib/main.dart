import 'package:flutter/material.dart';
import 'package:fluttertest/providers/albums_provider.dart';
import 'package:fluttertest/providers/photos_provider.dart';
import 'package:fluttertest/screens/albums_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GetAlbumProvider()),
        ChangeNotifierProvider.value(value: GetPhotoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: AlbumsPage(),
      ),
    );
  }
}
