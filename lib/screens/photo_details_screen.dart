import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoDetailsScreen extends StatefulWidget {
  final photoDetails;

  PhotoDetailsScreen({this.photoDetails});

  @override
  _PhotoDetailsScreenState createState() => _PhotoDetailsScreenState();
}

class _PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            image: DecorationImage(
              // colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(0.5), BlendMode.darken),
              image: NetworkImage("${widget.photoDetails.url}"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 150, left: 10),
            child: Text(
              widget.photoDetails.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
