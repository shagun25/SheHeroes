import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path()
      ..moveTo(0, height)
      ..lineTo(0, height - 3 * height / 4)
      ..quadraticBezierTo(width / 2, 0, width, height - 3 * height / 4)
      ..lineTo(width, height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class BottomTimeBar extends StatelessWidget {
  final Widget child;
  const BottomTimeBar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper:
            CustomShape(), // this is my own class which extendsCustomClipper
        child: Container(height: 70, child: child));
  }
}
