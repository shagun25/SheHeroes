import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class SOSButton extends StatefulWidget {
  final child;
  final onPressed;
  final double radius;
  final startColor;
  final index;
  final endColor;
  final fromEmergency;
  const SOSButton({
    Key key,
    this.child,
    this.onPressed,
    this.radius = 100,
    this.startColor,
    this.endColor,
    this.fromEmergency,
    this.index,
  }) : super(key: key);

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween()
      ..add(
          'color1',
          widget.index == 0
              ? ColorTween(end: widget.startColor, begin: Colors.grey[400])
              : ColorTween(begin: widget.startColor, end: Colors.grey[400]))
      ..add(
          'color2',
          widget.index == 0
              ? ColorTween(end: widget.startColor, begin: Colors.grey[400])
              : ColorTween(begin: widget.startColor, end: Colors.grey[400]));
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return CustomAnimation(
          control: CustomAnimationControl.MIRROR,

          builder: (context, child, value) {
            return Container(
              padding: EdgeInsets.all(20),

              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0x55f48fb1)),

              // duration: Duration(seconds: 1),

              // ignore: deprecated_member_use
              child: FlatButton(
                shape: CircleBorder(),
                onPressed: widget.onPressed,
                child: Container(
                  constraints: BoxConstraints.tight(
                      Size.fromRadius(constraints.biggest.width / 4)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: widget.fromEmergency == false
                            ? [widget.startColor, widget.endColor]
                            : [value.get('color1'), value.get('color2')]),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      shape: CircleBorder(),
                      onPressed: widget.onPressed,
                      child: widget.child),
                ),
              ),
            );
          },

          // playback: Playback.MIRROR,
          tween: tween,
          duration: Duration(milliseconds: 800),
          // delay: Duration(seconds: 3),
        );
      },
    );
  }
}
