import 'package:flutter/material.dart';
import 'package:flutter_explore/home.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Home(),
      // title: Text('Giel Labz',
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 30,
      //         color: Color(0xFFe996600))),
      image: Image.asset('assets/gelLogo.png'),
      backgroundColor: Colors.black,
      photoSize: 150,
      loaderColor: Color(0xFFEEDA28),
    );
  }
}

// {
//   Color loaderColor,
//   int seconds,
//   double photoSize,
//   dynamic onClick,
//   dynamic navigateAfterSeconds,
//   Text title = const Text(''),
//   Color backgroundColor = Colors.white,
//   TextStyle styleTextUnderTheLoader = const TextStyle(
//     fontSize: 18.0,
//     fontWeight: FontWeight.bold,
//     color: Colors.black
//   ),
//   Image image,
//   Text loadingText = const Text(""),
//   ImageProvider < Object > imageBackground,
//   Gradient gradientBackground
// }
