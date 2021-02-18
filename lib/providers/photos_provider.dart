import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/models/photo_model.dart';
import 'package:http/http.dart' as http;
import '../models/exceptionModel.dart';

class GetPhotoProvider with ChangeNotifier {
  List<Photos> photos;
  getphotos(albumId) async {
    final url = 'https://jsonplaceholder.typicode.com/photos?albumId=$albumId';

    try {
      final response = await http.get(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      // print(response.statusCode);
      // print(response.body);
      // print(json.decode(response.body));

      if (response.statusCode == 200) {
        photos = (json.decode(response.body) as List)
            .map((data) => Photos.fromJson(data))
            .toList();

        return photos;
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
