import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        threshold: 0.5,
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
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                                child: Image.file(_image),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _output != null
                                  ? Text("${_output[0]['label']}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))
                                  : Container(),
                              SizedBox(height: 20)
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
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
