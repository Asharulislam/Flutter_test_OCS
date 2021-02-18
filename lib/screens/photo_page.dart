import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/providers/photos_provider.dart';
import 'package:fluttertest/screens/photo_details_screen.dart';
import 'package:provider/provider.dart';

class PhotoPage extends StatefulWidget {
  static const routeName = 'photopage';

  final albumId;

  PhotoPage({this.albumId});
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Albums",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          Icon(Icons.grid_view, color: Colors.grey),
          SizedBox(width: 30),
          Icon(Icons.add, color: Colors.grey),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: Provider.of<GetPhotoProvider>(context, listen: false)
              .getphotos(widget.albumId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData == false) {
              return Center(child: Text("snapshot empty data"));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Recently",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "see all",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.all(4),
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoDetailsScreen(
                                    photoDetails: snapshot.data[index],
                                  ),
                                ),
                              );
                            },
                            child: GridTile(
                              footer: Card(
                                color: Colors.white60,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].title,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14),
                                  ),
                                  // subtitle: Padding(
                                  //   padding: const EdgeInsets.only(top: 5),
                                  //   child: Text(
                                  //     "Rs.${snapshot.data.result[index].price}",
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontWeight: FontWeight.w800,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ),
                              child: Card(
                                elevation: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image.network(
                                    snapshot.data[index].thumbnailUrl,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.black,
                                          // value: loadingProgress.expectedTotalBytes !=
                                          //         null
                                          //     ? loadingProgress.cumulativeBytesLoaded /
                                          //         loadingProgress.expectedTotalBytes
                                          //     : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
