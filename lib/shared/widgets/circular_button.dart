import 'package:flutter/material.dart';

class CircularButtonDashboard extends StatelessWidget {
  final IconData icon;
  final String text;
  final onPressed;
  final bool fromEmergency;
  CircularButtonDashboard(
      {this.icon, this.text, this.onPressed, this.fromEmergency});
  @override
  Widget build(BuildContext context) {
    final circularButtonWidth = MediaQuery.of(context).size.width / 3 - 22.5;
    return Container(
      height: circularButtonWidth,
      width: circularButtonWidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        shape: CircleBorder(),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color:
                  fromEmergency == true ? Colors.red : Color(0xffffc400),
              size: fromEmergency == true
                  ? MediaQuery.of(context).size.height / 15
                  : MediaQuery.of(context).size.width / 8,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
