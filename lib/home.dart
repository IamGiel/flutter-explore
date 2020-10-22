import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_explore/spider-detail.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/animation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // declared variables
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  // created functions
  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  pickGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      // showAlertDialog(context);
      return null;
    } else {}
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("CLOSE"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logger"),
      content: Text("This ensures error block is called or null or undefined"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('output ==== ');
    print(_output);
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          SizedBox(height: 50),
          Text('Alpha-Gel Apps', // convolutional nueral network
              style: TextStyle(color: Colors.black, fontSize: 12)),
          SizedBox(
            height: 6,
          ),
          Text('What Spider?', // convolutional nueral network
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 40),
          Center(
              child: _loading
                  ? Container(
                      width: 280,
                      child: Column(
                        children: [
                          Image.asset('assets/spider.png'),
                          SizedBox(height: 40)
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width - 180,
                            child: Image.file(_image),
                          ),
                          SizedBox(height: 20),

                          _output != null
                              ? GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red[200],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purple[300]
                                              .withOpacity(0.4),
                                          spreadRadius: 3,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      border:
                                          Border.all(color: Colors.purple[300]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          (_output[0]['confidence'] * 100)
                                                      .round() >
                                                  70
                                              ? Text(
                                                  "Its ${(_output[0]['confidence'] * 100).round()}% ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')} spider!",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20))
                                              : Text(
                                                  "Hmm.. Im only ${(_output[0]['confidence'] * 100).round()}% sure about this one.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20)),
                                          SizedBox(height: 20),
                                          (_output[0]['confidence'] * 100)
                                                      .round() <
                                                  70
                                              ? Text(
                                                  "But here's what I know about${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20))
                                              : Text(
                                                  "Here's what you should know about ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20)),
                                          SizedBox(height: 20),
                                          SizedBox(
                                              height: 40,
                                              width: 100,
                                              child: Container(
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 24,
                                                  semanticLabel:
                                                      'Text to announce in accessibility modes',
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.brown[100],
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.purple[300]
                                                          .withOpacity(0.4),
                                                      spreadRadius: 3,
                                                      blurRadius: 3,
                                                      offset: Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                      color:
                                                          Colors.purple[300]),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // showAlertDialog(context);
                                    // Navigate back to first route when tapped.
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SpiderDetails(
                                                spiderObject: _output[0])));
                                  },
                                )
                              : Container(
                                  child: Text('ouput is null'),
                                ),
                          SizedBox(height: 20),
                          (_output[0]['confidence'] * 100).round() < 80
                              ? Center(
                                  child: Text(
                                      'You can improve confidence level (${(_output[0]['confidence'] * 100).round()}) by getting a better image of the spider.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)))
                              : Center(
                                  child: Text(
                                      'Great image! I am (${(_output[0]['confidence'] * 100).round()}%) confident of this spiders information - ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white))),
                          SizedBox(height: 20),
                          // Text("testing")
                        ],
                      ),
                    )),
          Container(
            // === button container ===
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              GestureDetector(
                onTap: () {
                  // showAlertDialog(context);
                  pickImage();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 180,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                  decoration: BoxDecoration(
                      color: Colors.brown[700],
                      borderRadius: BorderRadius.circular(6)),
                  child: Text('Take a Photo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: pickGallery,
                child: Container(
                  width: MediaQuery.of(context).size.width - 180,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                  decoration: BoxDecoration(
                      color: Colors.brown[700],
                      borderRadius: BorderRadius.circular(6)),
                  child: Text('Camera Roll',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
