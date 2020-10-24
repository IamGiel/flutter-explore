import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_explore/spider-detail.dart';
import 'package:flutter_explore/widgets/custom_raised_button.dart';
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
    return Stack(children: <Widget>[
      Container(
        child: Image.asset(
          'assets/spiderbg.jpeg',
          // fit: BoxFit.cover,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text('', // convolutional nueral network
                      style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'What Spider?', // convolutional nueral network
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Center(
                      child: _loading
                          ? Container(
                              width: 280,
                              child: Column(
                                children: [
                                  Image.asset('assets/previewspider.webp'),
                                  SizedBox(height: 40)
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.file(_image),
                                  ),
                                  SizedBox(height: 20),

                                  _output != null
                                      ? GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue[200]
                                                  .withOpacity(0.5),
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
                                                  color: Colors.blue[300]),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.all(16.0),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  (_output[0]['confidence'] *
                                                                  100)
                                                              .round() >
                                                          70
                                                      ? _textAboveThreshold(
                                                          "Its ${(_output[0]['confidence'] * 100).round()}% ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}!")
                                                      : _textAboveThreshold(
                                                          "Hmm.. Im only ${(_output[0]['confidence'] * 100).round()}% sure about this one."),
                                                  SizedBox(height: 20),
                                                  (_output[0]['confidence'] *
                                                                  100)
                                                              .round() <
                                                          70
                                                      ? _textAboveThreshold(
                                                          "But here's what I know about ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}.")
                                                      : _textAboveThreshold(
                                                          "Here's what you should know about ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}."),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.brown[100],
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .purple[300]
                                                                  .withOpacity(
                                                                      0.4),
                                                              spreadRadius: 3,
                                                              blurRadius: 3,
                                                              offset: Offset(0,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                          border: Border.all(
                                                              color: Colors
                                                                  .purple[300]),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                    builder: (context) =>
                                                        SpiderDetails(
                                                            spiderObject:
                                                                _output[0])));
                                          },
                                        )
                                      : Container(
                                          child: Text('ouput is null'),
                                        ),
                                  SizedBox(height: 20),
                                  (_output[0]['confidence'] * 100).round() < 80
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue[200]
                                                .withOpacity(0.5),
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
                                                color: Colors.blue[100]),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                              child: Text(
                                                  'You can improve confidence level (${(_output[0]['confidence'] * 100).round()}) by getting a better image of the spider.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white))),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue[200]
                                                .withOpacity(0.5),
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
                                                color: Colors.blue[100]),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                              child: Text(
                                                  'Great image! I am (${(_output[0]['confidence'] * 100).round()}%) confident of this spiders information - ${_output[0]['label'].replaceAll(RegExp(r'\d'), '')}.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white))),
                                        ),
                                  SizedBox(height: 20),
                                  // Text("testing")
                                ],
                              ),
                            )),
                  Container(
                    // === button container ===
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: <Widget>[
                      CustomRaisedButton(
                        color: Colors.blue.withOpacity(0.2),
                        child: Text('Take a photo',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        onPressed: pickImage,
                      ),
                      SizedBox(height: 30),
                      CustomRaisedButton(
                        color: Colors.blue.withOpacity(0.2),
                        child: Text('Camera Roll',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        onPressed: pickGallery,
                      ),
                    ]),
                  )
                ]),
          ),
        ),
      )
    ]);
  }

  Container _textAboveThreshold(textHere) {
    return Container(
      child: Text("$textHere",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
