import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/album.dart';
import 'dart:async';
import 'dart:core';

// ignore: must_be_immutable
class CollageSpiderImages extends StatefulWidget {
  final spidey;
  var name;

  CollageSpiderImages({@required this.spidey, this.name}) : super(key: name);

  @override
  _CollageSpiderImagesState createState() => _CollageSpiderImagesState();
}

class _CollageSpiderImagesState extends State<CollageSpiderImages> {
  Future<Album> futureAlbum;
  var noImages = false;

  Future<Album> fetchAlbum() async {
    final response = await http.get(
        'https://pixabay.com/api/?key=18820463-2aeedeb390dc91fcf2042d5ff&per_page=6&q=${widget.spidey}');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("im here ");
      print(response.body);
      var res = Album.fromJson(jsonDecode(response.body));
      print(res.totalHits);
      if (res.totalHits == 0) {
        noImages = true;
      } else {
        noImages = false;
      }
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("More ${widget.spidey} images..."),
        ),
        body: Card(
          child: FutureBuilder<Album>(
            future: fetchAlbum(),
            builder: (context, AsyncSnapshot snapshot) {
              final Album data = snapshot.data;
              // print("snapshot.hasError");
              // print(snapshot.hasError);
              // print("snapshot.hasData");
              // print(snapshot.hasData);
              if (snapshot.hasData) {
                // if have images
                if (noImages == false) {
                  // show the image
                  return Expanded(
                      child: ListView.builder(
                          itemCount: data.hits.length,
                          itemBuilder: (context, index) {
                            return Container(
                                constraints: BoxConstraints.tightFor(
                                    width: 0.0, height: 200.0),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                  title: Image.network(
                                    data.hits[index]['largeImageURL'],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ));
                          }));
                } else
                // if no images
                if (noImages == true) {
                  // show the zero state
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: (Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("No Images returned from Pixabay")],
                    )),
                  );
                }
              } else if (snapshot.hasError) {
                return Column(children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ]);
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        )
                      ]),
                );
              }
            },
          ),
        ));
  }
}
