import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:safety/pages/self_defence.dart';
import 'package:safety/services/calls_and_messages_service.dart';
import 'package:safety/services/service_locator.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/pages/emergency_map.dart';
import 'package:safety/pages/center_map.dart';

class Homes extends StatefulWidget {
  // static AudioCache player = AudioCache();
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> with SingleTickerProviderStateMixin {
  final CallsAndMessagesService service = locator<CallsAndMessagesService>();
  final String number = "123456789";
  AnimationController _animationController;
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  void _runAnimation() async {
    while (true) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor('#FFC3CF'),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [HexColor('#FFC3CF'), HexColor('#F7BB97')],
                // begin: Alignment.topLeft,
                // end: Alignment.bottomRight
                radius: 1.5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment = MainAxisAlignment.spaceEvenly
            children: [
              Container(
                height: 100,
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: HexColor("#ea6a88")),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width - 10,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 70.0, // soften the shadow
                              spreadRadius: 20.0, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                0.0, // Move to bottom 5 Vertically
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(1000),
                          gradient: RadialGradient(radius: 0.7, colors: [
                            HexColor("#DD5E89"),
                            HexColor("#F7BB97"),
                          ]),
                          border:
                              Border.all(color: HexColor("#ea6a88"), width: 2)),
                      child: AvatarGlow(
                        endRadius: 200.0,
                        startDelay: Duration(seconds: 1),
                        glowColor: Colors.blueAccent,
                        child: CircleList(
                          initialAngle: 55,
                          outerRadius: MediaQuery.of(context).size.width / 2.2,
                          innerRadius: MediaQuery.of(context).size.width / 5,
                          showInitialAnimation: true,
                          innerCircleColor: Colors.white54,
                          outerCircleColor: Colors.white30,
                          origin: Offset(0, 0),
                          rotateMode: RotateMode.onlyChildrenRotate,
                          centerWidget: HomePage(),
                          children: [
                            // AvatarGlow(
                            //   endRadius: 70.0,
                            //   glowColor: Colors.pink,
                            //   child: Container(
                            //     padding: EdgeInsets.all(0),
                            //     width: 80,
                            //     height: 80,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(100),
                            //         // color: Colors.transparent,
                            //         border: Border.all(
                            //             color: HexColor("#ea6a88"), width: 3)),
                            //     child: RaisedButton(
                            //       elevation: 1,
                            //       color: Colors.white70,
                            //       onPressed: () {
                            //         Navigator.pushNamed(context, 'voice');
                            //       },
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(100)),
                            //       child: Column(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceEvenly,
                            //         children: [
                            //           Icon(
                            //             Icons.keyboard_voice,
                            //             size: 40,
                            //             color: HexColor("#b72334"),
                            //           ),
                            //           Text(
                            //             'VOICE',
                            //             style: TextStyle(
                            //                 color: HexColor("#b72334"),
                            //                 fontSize: 12,
                            //                 fontWeight: FontWeight.bold),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ), //(voice)
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: Hero(
                                  tag: 'MAP',
                                  child: RaisedButton(
                                    elevation: 1,
                                    color: Colors.white70,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyHomePage(),
                                          ));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.map,
                                          size: 40,
                                          color: HexColor("#b72334"),
                                        ),
                                        Text(
                                          'Map',
                                          style: TextStyle(
                                              color: HexColor("#b72334"),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ), //(Map)//
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: RaisedButton(
                                  elevation: 1,
                                  color: Colors.white70,
                                  onPressed: () => {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1200)),
                                                //this right here
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 20.0,
                                                        color:
                                                            Colors.orange[800]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3000.0),
                                                  ),
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2000.0)),
                                                    onPressed: () =>
                                                        service.call(number),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 55, right: 55),
                                                      height: 250,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          RotationTransition(
                                                            turns: Tween(
                                                                    begin: 0.0,
                                                                    end: -.1)
                                                                .chain(CurveTween(
                                                                    curve: Curves
                                                                        .elasticIn))
                                                                .animate(
                                                                    _animationController),
                                                            child: Icon(
                                                                Icons.call,
                                                                size: 70,
                                                                color: Color(
                                                                    0xffffc400)),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Call',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 20,
                                                              // fontWeight:
                                                              // FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1200)),
                                                //this right here
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 20.0,
                                                        color:
                                                            Colors.orange[800]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3000.0),
                                                  ),
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2000.0)),
                                                    onPressed: () =>
                                                        service.sendSms(number),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 55, right: 55),
                                                      height: 250,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          RotationTransition(
                                                            turns: Tween(
                                                                    begin: 0.0,
                                                                    end: -.1)
                                                                .chain(CurveTween(
                                                                    curve: Curves
                                                                        .elasticIn))
                                                                .animate(
                                                                    _animationController),
                                                            child: Icon(
                                                                Icons.message,
                                                                size: 70,
                                                                color: Color(
                                                                    0xffffc400)),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Message',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 20,
                                                              // fontWeight:
                                                              // FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                    _runAnimation(),
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.call,
                                        size: 40,
                                        color: HexColor("#b72334"),
                                      ),
                                      Text(
                                        'SOS',
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //(sos)
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: RaisedButton(
                                  elevation: 1,
                                  color: Colors.white70,
                                  onPressed: Constants.policeStaionFunction,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.local_parking,
                                        size: 40,
                                        color: HexColor("#b72334"),
                                      ),
                                      Text(
                                        'Police',
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //(Police)
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: RaisedButton(
                                  elevation: 1,
                                  color: Colors.white70,
                                  onPressed: Constants.taxiButton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.local_taxi,
                                        size: 40,
                                        color: HexColor("#b72334"),
                                      ),
                                      Text(
                                        'Taxi',
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //(Taxi)
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: RaisedButton(
                                  elevation: 1,
                                  color: Colors.white70,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1200)),
                                                //this right here
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 20.0,
                                                        color:
                                                            Colors.orange[800]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3000.0),
                                                  ),
                                                  child: RaisedButton(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2000.0)),
                                                    onPressed: () => {
                                                      setState(() {
                                                        Timer(
                                                            Duration(
                                                                seconds: 10),
                                                            () {
                                                          assetsAudioPlayer
                                                              .stop();
                                                          Navigator.pop(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Homes()));
                                                          print('stop');
                                                        });
                                                        assetsAudioPlayer.open(
                                                          Audio(
                                                              "music/police.mp3"),
                                                        );
                                                      }),
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 35, right: 35),
                                                      height: 250,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          RotationTransition(
                                                            turns: Tween(
                                                                    begin: 0.0,
                                                                    end: -.1)
                                                                .chain(CurveTween(
                                                                    curve: Curves
                                                                        .elasticIn))
                                                                .animate(
                                                                    _animationController),
                                                            child: Icon(
                                                                Icons
                                                                    .notifications_active,
                                                                size: 70,
                                                                color: Color(
                                                                    0xffffc400)),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Playing Siren\n\n Tap to play again',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 20,
                                                              // fontWeight:
                                                              // FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                    _runAnimation();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.speaker_phone,
                                        size: 40,
                                        color: HexColor("#b72334"),
                                      ),
                                      Text(
                                        'Siren',
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //(siren)
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: RaisedButton(
                                  elevation: 1,
                                  color: Colors.white70,
                                  onPressed: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Ho()),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.live_tv,
                                        size: 40,
                                        color: HexColor("#b72334"),
                                      ),
                                      Text(
                                        'News',
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //news
                            AvatarGlow(
                              endRadius: 70.0,
                              glowColor: Colors.pink,
                              child: Container(
                                padding: EdgeInsets.all(0),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    // color: Colors.transparent,
                                    border: Border.all(
                                        color: HexColor("#ea6a88"), width: 3)),
                                child: RaisedButton(
                                  elevation: 1,
                                  color: Colors.white70,
                                  onPressed: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 5000), () {
                                      // Here you can write your code
                                      Navigator.pop(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Homes()));
                                      print('stop');
                                    });
                                    Gradients.showMyDialog(
                                      context,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ShakeAnimatedWidget(
                                            enabled: true,
                                            duration:
                                                Duration(milliseconds: 100),
                                            shakeAngle: Rotation.deg(z: 5),
                                            curve: Curves.linear,
                                            child: Transform.rotate(
                                              angle: (pi / 180) * -35,
                                              child: Icon(Constants.shakeIcon,
                                                  size: 70,
                                                  color: Color(0xffffc400)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Shake to capture and activate emergency',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 20,
                                              // fontWeight:
                                              // FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      () {},
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.vibration,
                                        size: 40,
                                        color: HexColor("#b72334"),
                                      ),
                                      Text(
                                        'Shake',
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //(shake)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'voice');
        },
        child: Icon(
          Icons.keyboard_voice,
          size: 40,
          color: Colors.blue,
          // hoverColor: Colors.white,
        ),
        backgroundColor: HexColor("#b72334"),
      ),
    );
  }
}
