import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/albums_model.dart';
import 'package:http/http.dart' as http;
import '../models/exceptionModel.dart';

class GetAlbumProvider with ChangeNotifier {
  List<Albums> albums;
  getAlbum() async {
    final url = 'https://jsonplaceholder.typicode.com/albums';

    try {
      final response = await http.get(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      // print(response.statusCode);
      // print(response.body);
      // print(json.decode(response.body));

      if (response.statusCode == 200) {
        albums = (json.decode(response.body) as List)
            .map((data) => new Albums.fromJson(data))
            .toList();

        return albums;
      } else if (response.statusCode == 500) {
        return "no data";
      }
    } on SocketException {
      throw VerificationException('No Internet connection');
    } on HttpException {
      throw VerificationException('No service');
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
}
