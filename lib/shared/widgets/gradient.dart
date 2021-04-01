import 'package:flutter/widgets.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  GradientWidget({this.child, this.gradient});
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        child: child,
        shaderCallback: (Rect bounds) {
          return gradient.createShader(bounds);
        });
  }
}
