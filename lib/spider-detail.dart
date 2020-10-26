import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_explore/collage-spider.dart';
import 'dart:convert' show jsonDecode;

import 'package:flutter_explore/widgets/custom_raised_button.dart';

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
        title: Text('Know this...'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16),
              child: Center(
                  child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/spiders/spider_details.json'),
                builder: (context, snapshot) {
                  var myJsonData = jsonDecode(snapshot.data);
                  for (var i = 0; i < myJsonData.length; i++) {
                    if (myJsonData[i]['name'].indexOf(spiderName) > -1) {
                      isolatedSpider = myJsonData[i];
                    }
                  }
                  return Scaffold(
                    // resizeToAvoidBottomPadding: false,
                    body: ListView(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Stack(
                          children: <Widget>[
                            Column(
                              children: [
                                SizedBox(height: 5),
                                CustomRaisedButton(
                                  color: Colors.red[200],
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CollageSpiderImages(
                                                    spidey: spiderName)));
                                  },
                                  child: Text('See other photos of $spiderName',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 15),
                                _buildContainer(
                                    context,
                                    isolatedSpider['description'],
                                    Colors.cyan[100],
                                    'Description'),
                                SizedBox(height: 20),
                                _buildContainer(
                                    context,
                                    isolatedSpider['toxicity'],
                                    Colors.yellow[100],
                                    'The bite'),
                                SizedBox(height: 20),
                                _buildContainer(
                                    context,
                                    isolatedSpider['treatment'],
                                    Colors.green[200],
                                    'Treatments')
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ))),
        ],
      ),
    );
  }

  Container _buildContainer(BuildContext context, spiderInfo, colors, title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200].withOpacity(0.9),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(2),
      ),
      height: 200,
      child: Align(
        alignment: Alignment.topLeft,
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text(
              '$title:',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '${spiderInfo}',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
