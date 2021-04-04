import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:hexcolor/hexcolor.dart';


class SafeHome extends StatefulWidget {
  @override
  _SafeHomeState createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircleList(
        initialAngle: 55,
        outerRadius: MediaQuery.of(context).size.width / 2,
        innerRadius: MediaQuery.of(context).size.width / 4,
        showInitialAnimation: true,
        innerCircleColor: Colors.white54,
        outerCircleColor: Colors.white30,
        origin: Offset(0, 0),
        rotateMode: RotateMode.onlyChildrenRotate,
        centerWidget: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image: AssetImage('assets/map.png'))),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.transparent,
                border: Border.all(color: HexColor('#ea6a88'), width: 3)),
            // ignore: deprecated_member_use
            child: RaisedButton(
              elevation: 1,
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_voice,
                        size: 10,
                        color: HexColor('#b72334'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.transparent,
                border: Border.all(color: HexColor('#ea6a88'), width: 3)),
            // ignore: deprecated_member_use
            child: RaisedButton(
              elevation: 1,
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_taxi,
                        size: 10,
                        color: HexColor('#b72334'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.transparent,
                border: Border.all(color: HexColor('#ea6a88'), width: 3)),
            // ignore: deprecated_member_use
            child: RaisedButton(
              elevation: 1,
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.vibration,
                        size: 10,
                        color: HexColor('#b72334'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.transparent,
                border: Border.all(color: HexColor('#ea6a88'), width: 3)),
            // ignore: deprecated_member_use
            child: RaisedButton(
              elevation: 1,
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.speaker_phone,
                        size: 10,
                        color: HexColor('#b72334'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.transparent,
                border: Border.all(color: HexColor('#ea6a88'), width: 3)),
            // ignore: deprecated_member_use
            child: RaisedButton(
              elevation: 1,
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SOS',
                        style: TextStyle(
                          color: HexColor('#b72334'),
                          fontSize: 6,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.transparent,
                border: Border.all(color: HexColor('#ea6a88'), width: 3)),
            // ignore: deprecated_member_use
            child: RaisedButton(
              elevation: 1,
              color: Colors.white70,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_parking,
                        size: 10,
                        color: HexColor('#b72334'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
