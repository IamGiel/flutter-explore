import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert' show json, jsonDecode;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'models/spider.dart';

// ignore: must_be_immutable
class SpiderDetails extends StatelessWidget {
  var data;
  var name;
  var description;
  final spiderObject;

  SpiderDetails({@required this.spiderObject, this.name, this.description})
      : super(key: name);

  // Future<List> loadAsset() async {
  //   Future.delayed(Duration(seconds: 2));
  //   this.data =
  //       await rootBundle.loadString('assets/spiders/spider_details.json');
  //   return this.data;
  // }

  @override
  Widget build(BuildContext context) {
    var spiderName = this.spiderObject['label'].replaceAll(RegExp(r'\d '), '');
    var isolatedSpider;
    return Scaffold(
      appBar: AppBar(
        title: Text('The $spiderName'),
      ),
      body: Container(
        child: Center(
            child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/spiders/spider_details.json'),
          builder: (context, snapshot) {
            var myJsonData = jsonDecode(snapshot.data);

            for (var i = 0; i < myJsonData.length; i++) {
              if (myJsonData[i]['name'].indexOf(spiderName) > -1) {
                print(myJsonData[i]);
                isolatedSpider = myJsonData[i];
              }
            }
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              body: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.cyan[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple[300].withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              border: Border.all(color: Colors.purple[300]),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            height: 200,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ListView(
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Appearance:',
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '${isolatedSpider['description']}',
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple[300].withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              border: Border.all(color: Colors.purple[300]),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            height: 200,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: ListView(
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Toxicity:',
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '${isolatedSpider['toxicity']}',
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        )),
        // child: new FutureBuilder(
        // future: DefaultAssetBundle.of(context)
        //     .loadString('../assets/spiders/spider_details.json'),
        // )
      ),
    );
  }
}
