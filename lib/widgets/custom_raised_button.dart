import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {@required this.child,
      @required this.color,
      this.borderRadius: 10.0,
      @required this.onPressed,
      this.height: 50.0,
      this.width: 300.0})
      : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white)),
        onPressed: onPressed,
      ),
    );
  }
}
