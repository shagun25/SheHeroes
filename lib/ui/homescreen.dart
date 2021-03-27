import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:circle_list/circle_list.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:safety/pages/Voice.dart';
import 'package:safety/pages/center_map.dart';
import 'package:safety/pages/emergency_map.dart';
import 'package:safety/pages/login_page.dart';
import 'package:safety/pages/nearby_places.dart';
import 'package:safety/pages/photo_capture.dart';
import 'package:safety/pages/video_capture.dart';
import 'package:safety/pages/self_defence.dart';
import 'package:safety/services/calls_and_messages_service.dart';
import 'package:safety/services/service_locator.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/services/googleAuth.dart';

class Homes extends StatefulWidget {
  // static AudioCache player = AudioCache();
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> with SingleTickerProviderStateMixin {
  Location _location = Location();
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

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

  // void _onTapped(int index){
  //   setState((){
  //     _currentIndex=index;
  //   });
  //   if(_currentIndex==0){
  //     Navigator.push(
  //       context,
  //        MaterialPageRoute(
  //       builder: (context) =>
  //       CameraSwitcher()));
  //   }
  //   else if(_currentIndex==1){
  //     Navigator.pushNamed(context, 'voice');
  //   }
  //   else if(_currentIndex==2){
  //    Navigator.push(
  //          context,
  //           MaterialPageRoute(
  //            builder: (context) => NearBy()));
  //   }
  // }
  void _runAnimation() async {
    while (true) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  static void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  int incidentcount = 0;
  String message = 'SAFE';

  void countincident() {
    incidentcount = 0;
    for (int i = 0; i < data['incidents'].length; i++) {
      double distance = sqrt((lat - data['incidents'][i]['lat']) *
              (lat - data['incidents'][i]['lat']) +
          (lon - data['incidents'][i]['lng']) *
              (lon - data['incidents'][i]['lng']));
      if (distance < 0.0001) {
        incidentcount++;
        break;
      }
    }
    setState(() {
      if (incidentcount == 0)
        message = 'SAFE';
      else
        message = 'UNSAFE';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor('#FFC3CF'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(top: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app_sharp,
                    color: Colors.red,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    var _gAuth = GoogleAuthenticate(context);
                    bool response = await _gAuth.logOut();
                    if (response) {
                      Future.delayed(Duration(milliseconds: 800)).then(
                          (value) => Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.route, (route) => false));
                    }
                  },
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScaleAnimatedTextKit(
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          "Dashboard",
                        ],
                        textStyle: TextStyle(
                            fontSize: 50.0,
                            fontFamily: "Canterbury",
                            color: HexColor("#ea6a88"),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional
                            .topStart // or Alignment.topLeft
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
                          centerWidget: InkWell(
                            onDoubleTap: () {
                              Navigator.pushNamed(context, MyHomePage.route);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  // gradient: but,
                                  borderRadius: BorderRadius.circular(1000),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white70,
                                      blurRadius: 10.0, // soften the shadow
                                      spreadRadius: 10.0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        0.0, // Move to bottom 5 Vertically
                                      ),
                                    ),
                                  ],
                                ),
                                child: HomePage()),
                          ),
                          children: [
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
                                                    onPressed: () async {
                                                      Position position =
                                                          await Geolocator()
                                                              .getCurrentPosition();

                                                      final coordinates =
                                                          new Coordinates(
                                                              position.latitude,
                                                              position
                                                                  .longitude);
                                                      var addresses = await Geocoder
                                                          .local
                                                          .findAddressesFromCoordinates(
                                                              coordinates);
                                                      var first =
                                                          addresses.first;
                                                      print(
                                                          "${first.featureName} : ${first.addressLine}");
                                                      String message =
                                                          "Help! I'm in an emergency. I'm at (${first.featureName}, ${first.addressLine}).";
                                                      List<String> recipents = [
                                                        "8920532416"
                                                      ];

                                                      _sendSMS(
                                                          message, recipents);
                                                    },
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
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
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
                                    countincident();
                                    setState(() {
                                      _location.onLocationChanged.listen;
                                    });
                                  },
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
                                        message,
                                        style: TextStyle(
                                            color: HexColor("#b72334"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ), //(Psafe)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        //activeIconColor:Color(0xffb72334) ,
        inactiveIconColor: Color(0xffb72334),
        barBackgroundColor: Colors.white70,
        circleColor: Color(0xffb72334),
        tabs: [
          TabData(
              iconData: Icons.camera,
              title: "Camera",
              onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(2);
                Navigator.pushNamed(context, PhotoCapture.route);
              }),
			  TabData(
              iconData: Icons.video_call,
              title: "Video",
              onclick: () {
                //final FancyBottomNavigationState fState = bottomNavigationKey.currentState;
                //fState.setPage(2);
                Navigator.pushNamed(context, VideoCapture.route);
              }),
          TabData(
            iconData: Icons.keyboard_voice,
            title: "Voice",
            onclick: () => Navigator.pushNamed(context, SpeechScreen.route),
          ),
          TabData(
            iconData: Icons.place,
            title: "Nearby",
            onclick: () => Navigator.pushNamed(context, NearbyPlaces.route),
          ),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      //  bottomNavigationBar: BottomNavigationBar(
      //    currentIndex: _currentIndex,
      //   //  decoration: BoxDecoration(
      //   //       gradient: RadialGradient(
      //   //           colors: [HexColor('#FFC3CF'), HexColor('#F7BB97')],
      //   //           // begin: Alignment.topLeft,
      //   //           // end: Alignment.bottomRight
      //   //           radius: 1.5)),
      //    onTap:_onTapped,
      //   backgroundColor:Color(0xfff7bcb3),
      //    iconSize: 35.0,
      //    selectedItemColor: Color(0xffb72334),
      //    unselectedItemColor:Color(0xffb72334),
      //    items: [
      //    BottomNavigationBarItem(icon: Icon(Icons.camera),label:""),
      //    BottomNavigationBarItem(icon: Icon(Icons.keyboard_voice),label:""),
      //    BottomNavigationBarItem(icon: Icon(Icons.place),label:"")
      //  ],),
      // bottomNavigationBar:Row(

      //   children: [
      //     Expanded(
      //                 child: FloatingActionButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, 'voice');
      //         },
      //         child: Icon(
      //           Icons.keyboard_voice,
      //           size: 40,
      //           color: HexColor("#b72334"),
      //           // hoverColor: Colors.white,
      //         ),
      //         backgroundColor: Colors.white70,
      //       ),
      //     ),
      //     Expanded(
      //                 child: FloatingActionButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, 'voice');
      //         },
      //         child: Icon(
      //           Icons.keyboard_voice,
      //           size: 40,
      //           color: HexColor("#b72334"),
      //           // hoverColor: Colors.white,
      //         ),
      //         backgroundColor: Colors.white70,
      //       ),
      //     ),
      //     Expanded(
      //                 child: FloatingActionButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, 'voice');
      //         },
      //         child: Icon(
      //           Icons.keyboard_voice,
      //           size: 40,
      //           color: HexColor("#b72334"),
      //           // hoverColor: Colors.white,
      //         ),
      //         backgroundColor: Colors.white70,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Map data = {
    "incidents": [
      {
        "id": "98518834",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.537991,
        "lng": -105.036377,
        "startTime": "2019-06-01T08:00:00",
        "endTime": "2021-06-01T17:01:00",
        "impacting": false,
        "shortDesc":
            "US-85 Santa Fe Dr: intermittent lane closures from CO-470 to Highlands Ranch Pkwy",
        "fullDesc":
            "Intermittent lane closures due to maintenance work on US-85 Santa Fe Dr both ways from CO-470 / US-85 Santa Fe Dr / County Line Rd to Highlands Ranch Pkwy.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 6.159999847412109,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "US-85 Santa Fe Dr / Highlands Ranch Pkwy / Dumont Way",
          "crossRoad1": "CO-470 / US-85 Santa Fe Dr / County Line Rd",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Intermittent Lane Closures, maintenance work",
          "roadName": "US-85"
        }
      },
      {
        "id": "132749372",
        "type": 1,
        "severity": 0,
        "eventCode": 504,
        "lat": 39.554127,
        "lng": -105.085052,
        "startTime": "2020-12-07T06:00:00",
        "endTime": "2020-12-07T18:01:00",
        "impacting": false,
        "shortDesc":
            "CO-121 Wadsworth Blvd: shoulder closed between CR-59 Chatfield Ave and CO-470",
        "fullDesc":
            "Shoulder closed due to maintenance work on CO-121 Wadsworth Blvd both ways between CR-59 Chatfield Ave and CO-470.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 2.430000066757202,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-470 / CO-121 Wadsworth Blvd",
          "crossRoad1":
              "CO-121 Wadsworth Blvd / CR-59 Chatfield Ave / Chatfield Ave",
          "position2": "and",
          "direction": "both ways",
          "position1": "between",
          "eventText": "Shoulder Closed, maintenance work",
          "fromLocation": "Meadowbrook Heights",
          "toLocation": "Marina Pointe",
          "roadName": "CO-121"
        }
      },
      {
        "id": "138089783",
        "type": 1,
        "severity": 1,
        "eventCode": 735,
        "lat": 39.558891,
        "lng": -105.230888,
        "startTime": "2020-12-04T04:12:46",
        "endTime": "2020-12-18T06:00:00",
        "impacting": false,
        "shortDesc": "Mariposa Dr: road closed from Quartz Trl to Ault Ln",
        "fullDesc":
            "Road closed due to construction work on Mariposa Dr both ways from Quartz Trl to Ault Ln. Detour in operation - Use Ault Ln.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Ault Ln / Mariposa Dr",
          "crossRoad1": "Mariposa Dr / Quartz Trl",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, construction work, detour in operation",
          "roadName": "Mariposa Dr"
        }
      },
      {
        "id": "137088643",
        "type": 1,
        "severity": 0,
        "eventCode": 515,
        "lat": 39.566044,
        "lng": -104.941772,
        "startTime": "2020-11-17T05:31:11",
        "endTime": "2020-12-14T06:00:00",
        "impacting": false,
        "shortDesc":
            "County Line Rd W/B: roadway reduced to two lanes from Holly St to Colorado Blvd",
        "fullDesc":
            "Roadway reduced to two lanes due to construction work on County Line Rd Westbound from Holly St to Colorado Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 1.6399999856948853,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "County Line Rd / Colorado Blvd",
          "crossRoad1": "County Line Rd / Holly St",
          "position2": "to",
          "direction": "Westbound",
          "position1": "from",
          "eventText":
              "Roadway reduced from n lanes to two lanes, construction work",
          "roadName": "County Line Rd"
        }
      },
      {
        "id": "137088659",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.566139,
        "lng": -104.922607,
        "startTime": "2020-11-17T05:31:11",
        "endTime": "2020-12-14T06:00:00",
        "impacting": false,
        "shortDesc":
            "County Line Rd E/B: construction work from Colorado Blvd to Holly St",
        "fullDesc":
            "Roadway reduced to one lane due to construction work on County Line Rd Eastbound from Colorado Blvd to Holly St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 1.6399999856948853,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "County Line Rd / Holly St",
          "crossRoad1": "County Line Rd / Colorado Blvd",
          "position2": "to",
          "direction": "Eastbound",
          "position1": "from",
          "eventText":
              "Construction work, roadway reduced from n lanes to one lane",
          "roadName": "County Line Rd"
        }
      },
      {
        "id": "133242432",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.577019,
        "lng": -105.085014,
        "startTime": "2020-12-07T06:00:00",
        "endTime": "2020-12-07T18:01:00",
        "impacting": false,
        "shortDesc":
            "CO-121 Wadsworth Blvd: intermittent lane closures between Coal Mine Ave and CR-59",
        "fullDesc":
            "Intermittent lane closures due to maintenance work on CO-121 Wadsworth Blvd both ways between Coal Mine Ave and CR-59 Chatfield Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 3.190000057220459,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2":
              "CO-121 Wadsworth Blvd / CR-59 Chatfield Ave / Chatfield Ave",
          "crossRoad1": "CO-121 Wadsworth Blvd / Coal Mine Ave",
          "position2": "and",
          "direction": "both ways",
          "position1": "between",
          "eventText": "Intermittent Lane Closures, maintenance work",
          "fromLocation": "Columbine West",
          "toLocation": "Meadowbrook Heights",
          "roadName": "CO-121"
        }
      },
      {
        "id": "132119529",
        "type": 1,
        "severity": 2,
        "eventCode": 816,
        "lat": 39.577705,
        "lng": -104.960381,
        "startTime": "2020-12-07T09:00:00",
        "endTime": "2020-12-07T15:01:00",
        "impacting": false,
        "shortDesc":
            "CO-177 N/B: construction during off-peak periods between CO-470 and Jamison Ave",
        "fullDesc":
            "Right lane closed due to construction during off-peak periods on CO-177 University Blvd Northbound between CO-470 and Jamison Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 1.590000033378601,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-177 University Blvd / Jamison Ave",
          "crossRoad1": "CO-470 / CO-177 University Blvd / University Blvd",
          "position2": "and",
          "direction": "Northbound",
          "position1": "between",
          "eventText":
              "Construction During Off-Peak Periods, (Named) Lane Closed",
          "roadName": "CO-177"
        }
      },
      {
        "id": "133448024",
        "type": 1,
        "severity": 2,
        "eventCode": 703,
        "lat": 39.595032,
        "lng": -104.840408,
        "startTime": "2020-12-07T06:00:00",
        "endTime": "2020-12-07T18:01:00",
        "impacting": false,
        "shortDesc": "CO-88 Arapahoe Rd: maintenance work at Revere Pkwy",
        "fullDesc":
            "Right turn lane closed due to maintenance work on CO-88 Arapahoe Rd both ways at Revere Pkwy.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-88 Arapahoe Rd / Revere Pkwy",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Maintenance work, (Named) Lane Closed",
          "toLocation": "Park Villas",
          "roadName": "CO-88"
        }
      },
      {
        "id": "138253128",
        "type": 1,
        "severity": 2,
        "eventCode": 500,
        "lat": 39.624142,
        "lng": -105.025482,
        "startTime": "2020-12-07T09:00:00",
        "endTime": "2020-12-07T15:00:00",
        "impacting": false,
        "shortDesc":
            "CO-88 Federal Blvd S/B: right lane closed near Belleview Ave",
        "fullDesc":
            "Right lane closed due to construction work on CO-88 Federal Blvd Southbound near Belleview Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Belleview Ave",
          "direction": "Southbound",
          "position1": "near",
          "eventText": "(Named) Lane Closed, construction work",
          "toLocation": "Littleton",
          "roadName": "CO-88"
        }
      },
      {
        "id": "138253226",
        "type": 1,
        "severity": 0,
        "eventCode": 504,
        "lat": 39.63401,
        "lng": -104.90744,
        "startTime": "2020-12-07T05:23:30",
        "endTime": "2020-12-12T07:00:00",
        "impacting": false,
        "shortDesc": "I-225: shoulder closed at I-25",
        "fullDesc":
            "Shoulder closed due to construction work on I-225 both ways at I-25.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "I-25 ",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Shoulder Closed, construction work",
          "toLocation": "Hampden South",
          "roadName": "I-225"
        }
      },
      {
        "id": "121935660",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.638561,
        "lng": -104.716347,
        "startTime": "2019-11-01T07:00:00",
        "endTime": "2021-02-28T17:01:00",
        "impacting": false,
        "shortDesc":
            "CO-30 Gun Club Rd: intermittent lane closures at Quincy Ave",
        "fullDesc":
            "Intermittent lane closures due to construction on CO-30 Gun Club Rd both ways at CO-30 Gun Club Rd / CO-30 Quincy Ave / CR-43 Gun Club Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2":
              "CO-30 Gun Club Rd / CO-30 Quincy Ave / CR-43 Gun Club Rd",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Intermittent Lane Closures, construction",
          "toLocation": "Conservatory",
          "roadName": "CO-30"
        }
      },
      {
        "id": "121935668",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.638561,
        "lng": -104.716347,
        "startTime": "2019-11-01T07:00:00",
        "endTime": "2021-02-28T17:01:00",
        "impacting": false,
        "shortDesc": "Quincy Ave: intermittent lane closures at CO-30",
        "fullDesc":
            "Intermittent lane closures due to construction on Quincy Ave both ways at CO-30 Gun Club Rd / CO-30 Quincy Ave / CR-43 Gun Club Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2":
              "CO-30 Gun Club Rd / CO-30 Quincy Ave / CR-43 Gun Club Rd",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Intermittent Lane Closures, construction",
          "toLocation": "Conservatory",
          "roadName": "Quincy Ave"
        }
      },
      {
        "id": "138253085",
        "type": 1,
        "severity": 2,
        "eventCode": 500,
        "lat": 39.65321,
        "lng": -104.940575,
        "startTime": "2020-12-07T05:18:46",
        "endTime": "2020-12-12T07:00:00",
        "impacting": false,
        "shortDesc":
            "CO-2 Colorado Blvd: right lane closed near US-285 Hampden Ave",
        "fullDesc":
            "Right lane closed due to construction work on CO-2 Colorado Blvd both ways near US-285 Hampden Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "US-285 Hampden Ave ",
          "direction": "both ways",
          "position1": "near",
          "eventText": "(Named) Lane Closed, construction work",
          "toLocation": "University Hills",
          "roadName": "CO-2"
        }
      },
      {
        "id": "138253056",
        "type": 1,
        "severity": 2,
        "eventCode": 500,
        "lat": 39.65321,
        "lng": -104.940575,
        "startTime": "2020-12-07T05:18:46",
        "endTime": "2020-12-12T07:00:00",
        "impacting": false,
        "shortDesc":
            "US-285 Hampden Ave W/B: right lane closed near Colorado Blvd",
        "fullDesc":
            "Right lane closed due to construction work on US-285 Hampden Ave Westbound near Colorado Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Colorado Blvd",
          "direction": "Westbound",
          "position1": "near",
          "eventText": "(Named) Lane Closed, construction work",
          "toLocation": "University Hills",
          "roadName": "US-285"
        }
      },
      {
        "id": "132725053",
        "type": 1,
        "severity": 3,
        "eventCode": 401,
        "lat": 39.657738,
        "lng": -105.223335,
        "startTime": "2020-12-07T04:30:00",
        "endTime": "2020-12-07T16:31:00",
        "impacting": true,
        "shortDesc":
            "CO-74 Bear Creek Rd: road closed between CO-8 Bear Creek Ave and Shady Ln",
        "fullDesc":
            "Road closed due to construction during the day time on CO-74 Bear Creek Rd both ways between CO-8 Bear Creek Ave and Shady Ln.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 5.630000114440918,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-74 Bear Creek Rd / Shady Ln",
          "crossRoad1": "CO-8 Bear Creek Ave / CO-74 Bear Creek Rd / Maple St",
          "position2": "and",
          "direction": "both ways",
          "position1": "between",
          "eventText": "Road closed, construction during the day time",
          "fromLocation": "Morrison",
          "toLocation": "Idledale",
          "roadName": "CO-74"
        }
      },
      {
        "id": "138253333",
        "type": 1,
        "severity": 3,
        "eventCode": 500,
        "lat": 39.65855,
        "lng": -104.843536,
        "startTime": "2020-12-07T07:00:00",
        "endTime": "2020-12-12T07:00:00",
        "impacting": false,
        "shortDesc":
            "I-225 S/B: right lane closed from Iliff Ave to CO-83 Parker Rd",
        "fullDesc":
            "Right lane closed and right hand shoulder closed due to construction work on I-225 Southbound from Iliff Ave to CO-83 Parker Rd.",
        "delayFromFreeFlow": 0.07000000029802322,
        "delayFromTypical": 0.0,
        "distance": 2.390000104904175,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-83 Parker Rd ",
          "crossRoad1": "Iliff Ave ",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText":
              "(Named) Lane Closed, right Hand Shoulder Closed, construction work",
          "fromLocation": "Southeast Crossing",
          "toLocation": "Dam East/West",
          "roadName": "I-225"
        }
      },
      {
        "id": "130853130",
        "type": 1,
        "severity": 0,
        "eventCode": 739,
        "lat": 39.659058,
        "lng": -104.842537,
        "startTime": "2020-06-29T00:00:00",
        "endTime": "2020-12-18T00:00:00",
        "impacting": false,
        "shortDesc": "I-225: construction at Exit 4 CO-83 Parker Rd",
        "fullDesc":
            "Right hand shoulder closed due to construction on I-225 both ways at Exit 4 CO-83 Parker Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "I-225  Exit 4 / CO-83 Parker Rd / CO-83",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Construction, right Hand Shoulder Closed",
          "toLocation": "Dam East/West",
          "roadName": "I-225"
        }
      },
      {
        "id": "138251502",
        "type": 1,
        "severity": 2,
        "eventCode": 638,
        "lat": 39.696384,
        "lng": -104.897682,
        "startTime": "2020-12-07T07:00:00",
        "endTime": "2020-12-12T07:00:00",
        "impacting": true,
        "shortDesc":
            "CO-83 Parker Rd W/B: turning lane closed at Mississippi Ave",
        "fullDesc":
            "Turning lane closed due to construction work on CO-83 Parker Rd Westbound at Mississippi Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-83 Parker Rd / Mississippi Ave",
          "direction": "Westbound",
          "position1": "at",
          "eventText": "Turning lane closed, construction work",
          "toLocation": "Windsor",
          "roadName": "CO-83"
        }
      },
      {
        "id": "125096285",
        "type": 1,
        "severity": 0,
        "eventCode": 493,
        "lat": 39.710873,
        "lng": -104.810097,
        "startTime": "2020-12-01T17:00:00",
        "endTime": "2020-12-07T19:01:00",
        "impacting": false,
        "shortDesc": "Alameda Dr: restrictions near Chambers Rd",
        "fullDesc":
            "Restrictions due to Holiday Tree Lighting on Alameda Dr both ways near Chambers Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Chambers Rd",
          "direction": "both ways",
          "position1": "near",
          "eventText": "Restrictions, other",
          "toLocation": "Aurora",
          "roadName": "Alameda Dr"
        }
      },
      {
        "id": "132967837",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.729988,
        "lng": -105.209267,
        "startTime": "2020-09-01T07:00:00",
        "endTime": "2021-01-04T17:01:00",
        "impacting": false,
        "shortDesc": "US-6: intermittent lane closures at CR-93 Heritage Rd",
        "fullDesc":
            "Intermittent lane closures due to construction on US-6 both ways at CR-93 Heritage Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "US-6 / CR-93 Heritage Rd / 10th Ave",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Intermittent Lane Closures, construction",
          "toLocation": "Lakota Hills",
          "roadName": "US-6"
        }
      },
      {
        "id": "121935794",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.7309,
        "lng": -104.847191,
        "startTime": "2020-01-01T07:00:00",
        "endTime": "2021-06-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "Peoria St: intermittent lane closures from I-70-BL Colfax Ave to Quari Ct",
        "fullDesc":
            "Intermittent lane closures due to construction on Peoria St both ways from I-70-BL Colfax Ave to Quari Ct.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 2.0799999237060547,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Peoria St / Quari Ct",
          "crossRoad1": "I-70-BL Colfax Ave / Peoria St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Intermittent Lane Closures, construction",
          "roadName": "Peoria St"
        }
      },
      {
        "id": "132704521",
        "type": 1,
        "severity": 2,
        "eventCode": 405,
        "lat": 39.733719,
        "lng": -104.969513,
        "startTime": "2020-08-26T01:40:12",
        "endTime": "2021-06-14T06:01:00",
        "impacting": true,
        "shortDesc":
            "11th Ave: no through traffic allowed from Lincoln St to Humboldt St",
        "fullDesc":
            "No through traffic allowed due to shared streets on 11th Ave both ways from Lincoln St to Humboldt St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 1.4299999475479126,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Humboldt St / 11th Ave",
          "crossRoad1": "Lincoln St / 11th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "No Through Traffic Allowed, other",
          "fromLocation": "Civic Center",
          "toLocation": "Cheeseman Park",
          "roadName": "11th Ave"
        }
      },
      {
        "id": "121935798",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.736111,
        "lng": -104.84304,
        "startTime": "2020-01-01T07:00:00",
        "endTime": "2021-06-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "13th Ave: intermittent lane closures from Peoria St to Revere St",
        "fullDesc":
            "Intermittent lane closures due to construction on 13th Ave both ways from Peoria St to Revere St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "13th Ave / Revere St",
          "crossRoad1": "Peoria St / 13th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Intermittent Lane Closures, construction",
          "roadName": "13th Ave"
        }
      },
      {
        "id": "126769530",
        "type": 1,
        "severity": 1,
        "eventCode": 401,
        "lat": 39.738461,
        "lng": -104.990242,
        "startTime": "2020-04-21T05:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": true,
        "shortDesc":
            "Bannock St S/B: road permanently closed from I-70-BL Colfax Ave to 14th Ave",
        "fullDesc":
            "Road permanently closed due to conversion to a pedestrian area on Bannock St Southbound from I-70-BL Colfax Ave to 14th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.18000000715255737,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Bannock St / 14th Ave",
          "crossRoad1": "I-70-BL Colfax Ave / 14th St / Bannock St",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Road permanently closed, other",
          "roadName": "Bannock St"
        }
      },
      {
        "id": "113799606",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.739723,
        "lng": -104.71859,
        "startTime": "2020-12-07T09:00:00",
        "endTime": "2020-12-07T15:01:00",
        "impacting": false,
        "shortDesc": "E-470: intermittent lane closures from Exit 13 to E-470",
        "fullDesc":
            "Intermittent lane closures due to construction during off-peak periods on E-470 both ways from Exit 13 Quincy Ave to E-470 Exit 20B / I-70 Exit 289.",
        "delayFromFreeFlow": 0.3499999940395355,
        "delayFromTypical": 0.25,
        "distance": 22.209999084472656,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "E-470  Exit 20B / I-70  Exit 289",
          "crossRoad1": "E-470  Exit 13 / Quincy Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, construction During Off-Peak Periods",
          "fromLocation": "Conservatory",
          "toLocation": "Tower Triangle",
          "roadName": "E-470"
        }
      },
      {
        "id": "132969402",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.740067,
        "lng": -104.987419,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "Broadway S/B: construction from 16th Ave to I-70-BL Colfax Ave",
        "fullDesc":
            "Parking restrictions in force due to construction on Broadway Southbound from 16th Ave to I-70-BL Colfax Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.18000000715255737,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "I-70-BL Colfax Ave / Broadway",
          "crossRoad1": "Broadway / 16th Ave",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Broadway"
        }
      },
      {
        "id": "123440770",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.741329,
        "lng": -104.991959,
        "startTime": "2019-12-23T07:00:00",
        "endTime": "2020-12-22T17:01:00",
        "impacting": false,
        "shortDesc": "14th St S/B: construction from Glenarm Pl to Tremont Pl",
        "fullDesc":
            "Parking restrictions in force due to construction on 14th St Southbound from Glenarm Pl to Tremont Pl.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.10999999940395355,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "14th St / Tremont Pl",
          "crossRoad1": "14th St / Glenarm Pl",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "14th St"
        }
      },
      {
        "id": "124723353",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.74144,
        "lng": -104.987373,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc": "16th St Mall: construction from Wynkoop St to Broadway",
        "fullDesc":
            "Construction on 16th St Mall both ways from Wynkoop St to Broadway.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Broadway / 16th St Mall",
          "crossRoad1": "Wynkoop St / 16th St Mall",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "fromLocation": "Union Station",
          "toLocation": "Central Business District",
          "roadName": "16th St Mall"
        }
      },
      {
        "id": "132704535",
        "type": 1,
        "severity": 2,
        "eventCode": 405,
        "lat": 39.741589,
        "lng": -104.956963,
        "startTime": "2020-08-26T01:40:12",
        "endTime": "2021-06-14T06:01:00",
        "impacting": true,
        "shortDesc":
            "16th Ave: no through traffic allowed from Lincoln St to City Park Esplanade",
        "fullDesc":
            "No through traffic allowed due to shared streets on 16th Ave both ways from Lincoln St to City Park Esplanade.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "16th Ave / City Park Esplanade",
          "crossRoad1": "Lincoln St / 16th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "No Through Traffic Allowed, other",
          "fromLocation": "Central Business District",
          "toLocation": "City Park",
          "roadName": "16th Ave"
        }
      },
      {
        "id": "132969604",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.74165,
        "lng": -104.98613,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "Lincoln St N/B: construction from I-70-BL Colfax Ave to 16th Ave",
        "fullDesc":
            "Parking restrictions in force due to construction on Lincoln St Northbound from I-70-BL Colfax Ave to 16th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.18000000715255737,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Lincoln St / 16th Ave",
          "crossRoad1": "I-70-BL Colfax Ave / Lincoln St",
          "position2": "to",
          "direction": "Northbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Lincoln St"
        }
      },
      {
        "id": "132802844",
        "type": 1,
        "severity": 3,
        "eventCode": 701,
        "lat": 39.742893,
        "lng": -104.736542,
        "startTime": "2020-12-07T00:00:00",
        "endTime": "2020-12-07T23:59:59",
        "impacting": false,
        "shortDesc":
            "I-70: intermittent lane closures between Exit 292 CO-36 Colfax Ave and E-470",
        "fullDesc":
            "Intermittent lane closures due to construction on I-70 both ways between Exit 292 CO-36 Colfax Ave and E-470.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 6.519999980926514,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "E-470",
          "crossRoad1": "I-70  Exit 292 / CO-36 Colfax Ave",
          "position2": "and",
          "direction": "both ways",
          "position1": "between",
          "eventText": "Intermittent Lane Closures, construction",
          "fromLocation": "Watkins",
          "toLocation": "Tower Triangle",
          "roadName": "I-70"
        }
      },
      {
        "id": "126298613",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.743229,
        "lng": -104.972153,
        "startTime": "2019-06-30T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "Marion St: construction from Marion St / 18th Ave to 17th Ave",
        "fullDesc":
            "Parking restrictions in force due to construction on Marion St both ways from Marion St / 18th Ave to 17th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Marion St / 17th Ave",
          "crossRoad1": "Marion St / 18th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Marion St"
        }
      },
      {
        "id": "132969638",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.743279,
        "lng": -104.983582,
        "startTime": "2020-07-25T07:00:00",
        "endTime": "2021-07-24T17:01:00",
        "impacting": false,
        "shortDesc": "Grant St S/B: construction from 18th Ave to 17th Ave",
        "fullDesc":
            "Parking restrictions in force due to construction on Grant St Southbound from 18th Ave to 17th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.17000000178813934,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "17th Ave / Grant St",
          "crossRoad1": "Grant St / 18th Ave",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Grant St"
        }
      },
      {
        "id": "132969397",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.743401,
        "lng": -104.987389,
        "startTime": "2020-07-26T07:00:00",
        "endTime": "2021-07-25T17:01:00",
        "impacting": false,
        "shortDesc": "17th St E/B: construction from Tremont Pl to Broadway",
        "fullDesc":
            "Parking restrictions in force due to construction on 17th St Eastbound from Tremont Pl to Broadway.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.10999999940395355,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Broadway / 17th Ave / Court Pl",
          "crossRoad1": "17th St / Tremont Pl",
          "position2": "to",
          "direction": "Eastbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "17th St"
        }
      },
      {
        "id": "132969372",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.744228,
        "lng": -104.993378,
        "startTime": "2020-07-31T07:00:00",
        "endTime": "2021-07-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "California St S/B: construction from 16th St Mall to 15th St",
        "fullDesc":
            "Parking restrictions in force due to construction on California St Southbound from 16th St Mall to 15th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.15000000596046448,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "15th St / California St",
          "crossRoad1": "California St / 16th St Mall",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "California St"
        }
      },
      {
        "id": "130439842",
        "type": 1,
        "severity": 1,
        "eventCode": 401,
        "lat": 39.744801,
        "lng": -104.989197,
        "startTime": "2020-06-18T07:39:38",
        "endTime": "2021-06-14T20:00:00",
        "impacting": true,
        "shortDesc":
            "Glenarm Pl: road closed from 15th St to Glenarm Pl / 17th St",
        "fullDesc":
            "Road closed due to outdoor dining on Glenarm Pl both ways from 15th St to Glenarm Pl / 17th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.5899999737739563,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Glenarm Pl / 17th St",
          "crossRoad1": "15th St / Glenarm Pl",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, other",
          "roadName": "Glenarm Pl"
        }
      },
      {
        "id": "128024205",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.744808,
        "lng": -104.984871,
        "startTime": "2019-11-24T07:00:00",
        "endTime": "2020-12-19T17:01:00",
        "impacting": false,
        "shortDesc": "Sherman St: construction from 17th Ave to 18th Ave",
        "fullDesc":
            "Construction on Sherman St both ways from 17th Ave to 18th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.3400000035762787,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Sherman St / 18th Ave",
          "crossRoad1": "Sherman St / 17th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Sherman St"
        }
      },
      {
        "id": "123103588",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.744808,
        "lng": -104.984871,
        "startTime": "2019-11-24T07:00:00",
        "endTime": "2020-12-19T17:01:00",
        "impacting": false,
        "shortDesc": "18th Ave W/B: construction from Grant St to Sherman St",
        "fullDesc":
            "Construction on 18th Ave Westbound from Grant St to Sherman St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.10999999940395355,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Sherman St / 18th Ave",
          "crossRoad1": "Grant St / 18th Ave",
          "position2": "to",
          "direction": "Westbound",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "18th Ave"
        }
      },
      {
        "id": "132969308",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.745979,
        "lng": -104.99807,
        "startTime": "2020-08-14T07:00:00",
        "endTime": "2021-08-13T17:01:00",
        "impacting": false,
        "shortDesc":
            "14th St S/B: construction from Lawrence St to Arapahoe St",
        "fullDesc":
            "Parking restrictions in force due to construction on 14th St Southbound from Lawrence St to Arapahoe St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.10999999940395355,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "14th St / Arapahoe St",
          "crossRoad1": "14th St / Lawrence St",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "14th St"
        }
      },
      {
        "id": "125900566",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.746971,
        "lng": -104.987411,
        "startTime": "2019-01-11T07:00:00",
        "endTime": "2021-01-10T17:01:00",
        "impacting": false,
        "shortDesc":
            "Broadway S/B: construction from Broadway / 20th St / California St to 19th St",
        "fullDesc":
            "Parking restrictions in force due to construction on Broadway Southbound from Broadway / 20th St / California St to 19th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.20999999344348907,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Broadway / 19th St",
          "crossRoad1": "Broadway / 20th St / California St",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Broadway"
        }
      },
      {
        "id": "130437795",
        "type": 1,
        "severity": 1,
        "eventCode": 401,
        "lat": 39.74736,
        "lng": -104.99984,
        "startTime": "2020-06-18T06:06:54",
        "endTime": "2021-06-14T06:01:00",
        "impacting": true,
        "shortDesc": "Larimer St W/B: road closed from 15th St to 14th St",
        "fullDesc":
            "Road closed due to outdoor seating on Larimer St Westbound from 15th St to 14th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.14000000059604645,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "14th St / Larimer St",
          "crossRoad1": "Larimer St / 15th St",
          "position2": "to",
          "direction": "Westbound",
          "position1": "from",
          "eventText": "Road closed, other",
          "roadName": "Larimer St"
        }
      },
      {
        "id": "133230662",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.74736,
        "lng": -104.99984,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc": "Larimer St W/B: construction from 15th St to 14th St",
        "fullDesc":
            "Parking restrictions in force due to construction on Larimer St Westbound from 15th St to 14th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.14000000059604645,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "14th St / Larimer St",
          "crossRoad1": "Larimer St / 15th St",
          "position2": "to",
          "direction": "Westbound",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Larimer St"
        }
      },
      {
        "id": "132704545",
        "type": 1,
        "severity": 2,
        "eventCode": 405,
        "lat": 39.748741,
        "lng": -105.042831,
        "startTime": "2020-08-26T01:40:12",
        "endTime": "2021-06-14T06:01:00",
        "impacting": true,
        "shortDesc":
            "Stuart St S/B: no through traffic allowed from 24th Ave to 21st Ave",
        "fullDesc":
            "No through traffic allowed due to shared streets on Stuart St Southbound from 24th Ave to 21st Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Stuart St / 21st Ave",
          "crossRoad1": "24th Ave",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "No Through Traffic Allowed, other",
          "roadName": "Stuart St"
        }
      },
      {
        "id": "132969725",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.74947,
        "lng": -104.973381,
        "startTime": "2020-08-20T07:00:00",
        "endTime": "2021-02-11T17:01:00",
        "impacting": false,
        "shortDesc": "Downing St N/B: construction from 21st Ave to 22nd Ave",
        "fullDesc":
            "Construction on Downing St Northbound from 21st Ave to 22nd Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.15000000596046448,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Downing St / 22nd Ave",
          "crossRoad1": "Downing St / 21st Ave",
          "position2": "to",
          "direction": "Northbound",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Downing St"
        }
      },
      {
        "id": "132704531",
        "type": 1,
        "severity": 2,
        "eventCode": 405,
        "lat": 39.751659,
        "lng": -105.042831,
        "startTime": "2020-08-26T01:40:12",
        "endTime": "2021-06-14T06:01:00",
        "impacting": true,
        "shortDesc":
            "Byron Pl: no through traffic allowed from Zenobia St to Stuart St",
        "fullDesc":
            "No through traffic allowed due to shared streets on Byron Pl both ways from Zenobia St to Stuart St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Stuart St / Byron Pl",
          "crossRoad1": "Zenobia St / Byron Pl",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "No Through Traffic Allowed, other",
          "roadName": "Byron Pl"
        }
      },
      {
        "id": "133230162",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.751881,
        "lng": -105.0009,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc": "16th St : construction from Wewatta St to Wynkoop St",
        "fullDesc":
            "Construction on 16th St both ways from Wewatta St to Wynkoop St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Wynkoop St ",
          "crossRoad1": "Wewatta St ",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "16th St "
        }
      },
      {
        "id": "133230331",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.752159,
        "lng": -104.99884,
        "startTime": "2018-01-29T07:00:00",
        "endTime": "2021-01-28T17:01:00",
        "impacting": false,
        "shortDesc": "Wazee St: construction from 16th St Mall to 17th St",
        "fullDesc":
            "Parking restrictions in force due to construction on Wazee St both ways from 16th St Mall to 17th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.28999999165534973,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "17th St / Wazee St",
          "crossRoad1": "16th St Mall / Wazee St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Wazee St"
        }
      },
      {
        "id": "130044805",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.75264,
        "lng": -104.982513,
        "startTime": "2020-05-18T07:00:00",
        "endTime": "2020-12-29T17:01:00",
        "impacting": false,
        "shortDesc": "24th St: construction from Stout St to California St",
        "fullDesc":
            "Construction on 24th St both ways from Stout St to California St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "24th St / California St",
          "crossRoad1": "Stout St / 24th St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "24th St"
        }
      },
      {
        "id": "133230484",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.753101,
        "lng": -104.99762,
        "startTime": "2018-03-20T07:00:00",
        "endTime": "2021-03-21T17:01:00",
        "impacting": false,
        "shortDesc":
            "Wazee St: construction from 17th St to Wazee St / 18th St",
        "fullDesc":
            "Parking restrictions in force due to construction on Wazee St both ways from 17th St to Wazee St / 18th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.30000001192092896,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Wazee St / 18th St",
          "crossRoad1": "17th St / Wazee St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Wazee St"
        }
      },
      {
        "id": "133230143",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.753208,
        "lng": -105.002586,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "Wewatta St: construction from 17th St / Wewatta St to 16th St",
        "fullDesc":
            "Construction on Wewatta St both ways from 17th St / Wewatta St to 16th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.25999999046325684,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Wewatta St / 16th St",
          "crossRoad1": "17th St / Wewatta St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Wewatta St"
        }
      },
      {
        "id": "130209181",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.754009,
        "lng": -104.996407,
        "startTime": "2020-06-22T07:00:00",
        "endTime": "2021-09-06T17:01:00",
        "impacting": false,
        "shortDesc":
            "Wazee St: construction from Wazee St / 18th St to 19th St",
        "fullDesc":
            "Construction on Wazee St both ways from Wazee St / 18th St to 19th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.28999999165534973,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "19th St / Wazee St",
          "crossRoad1": "Wazee St / 18th St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Wazee St"
        }
      },
      {
        "id": "130044456",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.754269,
        "lng": -104.982178,
        "startTime": "2020-05-19T07:00:00",
        "endTime": "2020-12-29T17:01:00",
        "impacting": false,
        "shortDesc": "Stout St N/B: construction from 24th St to 25th St",
        "fullDesc":
            "Construction on Stout St Northbound from 24th St to 25th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.15000000596046448,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Stout St / 25th St",
          "crossRoad1": "Stout St / 24th St",
          "position2": "to",
          "direction": "Northbound",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Stout St"
        }
      },
      {
        "id": "132969027",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.7547,
        "lng": -104.997353,
        "startTime": "2020-05-30T07:00:00",
        "endTime": "2021-05-29T17:01:00",
        "impacting": false,
        "shortDesc": "Wynkoop St: construction from 18th St to 19th St",
        "fullDesc":
            "Parking restrictions in force due to construction on Wynkoop St both ways from 18th St to 19th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.2800000011920929,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "19th St",
          "crossRoad1": "Wynkoop St / 18th St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Wynkoop St"
        }
      },
      {
        "id": "133229885",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.75695,
        "lng": -104.985687,
        "startTime": "2020-05-24T07:00:00",
        "endTime": "2021-05-23T17:01:00",
        "impacting": false,
        "shortDesc": "25th St: construction from Larimer St to Lawrence St",
        "fullDesc":
            "Parking restrictions in force due to construction on 25th St both ways from Larimer St to Lawrence St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Lawrence St / 25th St",
          "crossRoad1": "Larimer St / 25th St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "25th St"
        }
      },
      {
        "id": "131224339",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.757408,
        "lng": -105.010498,
        "startTime": "2020-06-21T07:00:00",
        "endTime": "2021-09-29T17:01:00",
        "impacting": false,
        "shortDesc": "Central St: construction from 16th St to 15th St",
        "fullDesc":
            "Construction on Central St both ways from 16th St to 15th St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.28999999165534973,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "15th St / Central St / Central Pl",
          "crossRoad1": "Central St / 16th St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Central St"
        }
      },
      {
        "id": "121935047",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.757591,
        "lng": -104.855309,
        "startTime": "2020-12-07T07:00:00",
        "endTime": "2020-12-07T17:31:00",
        "impacting": false,
        "shortDesc":
            "Martin Luther King Blvd: intermittent lane closures from Havana St to Moline St",
        "fullDesc":
            "Intermittent lane closures due to construction during the day time on Martin Luther King Blvd both ways from Havana St to Moline St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 1.4199999570846558,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Moline St",
          "crossRoad1": "Havana St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, construction during the day time",
          "roadName": "Martin Luther King Blvd"
        }
      },
      {
        "id": "121935065",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.75782,
        "lng": -104.856308,
        "startTime": "2019-11-01T07:00:00",
        "endTime": "2021-01-31T17:31:00",
        "impacting": false,
        "shortDesc":
            "Lima St: construction from 28th Pl to Martin Luther King Blvd",
        "fullDesc":
            "Restrictions due to construction on Lima St both ways from 28th Pl to Martin Luther King Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Martin Luther King Blvd",
          "crossRoad1": "28th Pl / Lima St / Macon Way",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, restrictions",
          "roadName": "Lima St"
        }
      },
      {
        "id": "138089850",
        "type": 1,
        "severity": 1,
        "eventCode": 735,
        "lat": 39.758072,
        "lng": -105.170197,
        "startTime": "2020-12-07T00:00:00",
        "endTime": "2020-12-09T23:59:00",
        "impacting": true,
        "shortDesc":
            "Kendrick St: road closed from CR-181 32nd Ave to 29th Ave",
        "fullDesc":
            "Road closed due to construction work on Kendrick St both ways from CR-181 32nd Ave to 29th Ave. Detour in operation - Use W 29th St and Indiana St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.6899999976158142,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Kendrick St / 29th Ave",
          "crossRoad1": "CR-181 32nd Ave / Kendrick St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, construction work, detour in operation",
          "roadName": "Kendrick St"
        }
      },
      {
        "id": "132968991",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.758419,
        "lng": -104.998451,
        "startTime": "2020-08-14T07:00:00",
        "endTime": "2021-02-13T17:01:00",
        "impacting": false,
        "shortDesc": "Inca St: construction at 29th Ave",
        "fullDesc":
            "Parking restrictions in force due to construction on Inca St both ways at 29th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Inca St / 29th Ave",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Construction, parking Restrictions In Force",
          "toLocation": "Union Station",
          "roadName": "Inca St"
        }
      },
      {
        "id": "121935070",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.758808,
        "lng": -104.863052,
        "startTime": "2019-11-01T07:00:00",
        "endTime": "2021-01-31T17:31:00",
        "impacting": false,
        "shortDesc":
            "Ironton St: construction from 28th Pl to Martin Luther King Blvd",
        "fullDesc":
            "Restrictions due to construction on Ironton St both ways from 28th Pl to Martin Luther King Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Martin Luther King Blvd",
          "crossRoad1": "Ironton St / 28th Pl",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, restrictions",
          "roadName": "Ironton St"
        }
      },
      {
        "id": "130150541",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.7603,
        "lng": -105.1436,
        "startTime": "2020-05-30T00:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": true,
        "shortDesc": "I-70 W/B: entry ramp from W 32nd Ave construction.",
        "fullDesc":
            "Entry ramp to I-70 Westbound from W 32nd Ave restrictions on entry ramp due to construction. Traffic will now use the new WB I-70 on ramp from Clear Creek Dr..",
        "delayFromFreeFlow": 0.07000000029802322,
        "delayFromTypical": 0.07000000029802322,
        "distance": 1.9299999475479126,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "W 32nd Ave / I-70",
          "direction": "None",
          "position1": "at",
          "eventText": "Construction, restrictions on entry ramp",
          "toLocation": "Applewood",
          "roadName": "W 32nd Ave"
        }
      },
      {
        "id": "125343319",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.760441,
        "lng": -105.00412,
        "startTime": "2020-01-19T07:00:00",
        "endTime": "2021-01-21T17:01:00",
        "impacting": false,
        "shortDesc": "Platte St: construction from 17th St to 19th St",
        "fullDesc":
            "Construction on Platte St both ways from 17th St to 19th St.",
        "delayFromFreeFlow": 0.10000000149011612,
        "delayFromTypical": 0.0,
        "distance": 0.6600000262260437,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Platte St / 19th St",
          "crossRoad1": "17th St / Platte St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "Platte St"
        }
      },
      {
        "id": "126218422",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.762032,
        "lng": -105.009552,
        "startTime": "2020-01-31T07:00:00",
        "endTime": "2021-06-30T17:01:00",
        "impacting": false,
        "shortDesc": "Shoshone St: construction from 33rd Ave to 32nd Ave",
        "fullDesc":
            "Parking restrictions in force due to construction on Shoshone St both ways from 33rd Ave to 32nd Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "32nd Ave / Shoshone St / Erie St",
          "crossRoad1": "33rd Ave / Shoshone St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "Shoshone St"
        }
      },
      {
        "id": "126218435",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.762032,
        "lng": -105.006592,
        "startTime": "2020-01-31T07:00:00",
        "endTime": "2021-06-30T17:01:00",
        "impacting": false,
        "shortDesc": "32nd Ave: construction from Shoshone St to Pecos St",
        "fullDesc":
            "Parking restrictions in force due to construction on 32nd Ave both ways from Shoshone St to Pecos St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.5099999904632568,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Pecos St",
          "crossRoad1": "32nd Ave / Shoshone St / Erie St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, parking Restrictions In Force",
          "roadName": "32nd Ave"
        }
      },
      {
        "id": "131334379",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.762032,
        "lng": -104.97213,
        "startTime": "2020-07-13T07:00:00",
        "endTime": "2021-03-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Marion St: intermittent lane closures from 27th Ave to Martin Luther King Blvd",
        "fullDesc":
            "Intermittent lane closures due to sewer works on Marion St both ways from 27th Ave to Martin Luther King Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Martin Luther King Blvd / Marion St",
          "crossRoad1": "Marion St / 27th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Intermittent Lane Closures, sewer Works",
          "roadName": "Marion St"
        }
      },
      {
        "id": "130197914",
        "type": 1,
        "severity": 1,
        "eventCode": 735,
        "lat": 39.768589,
        "lng": -104.983063,
        "startTime": "2019-11-19T07:00:00",
        "endTime": "2020-12-31T17:01:00",
        "impacting": true,
        "shortDesc": "Arkins Ct: road closed from 35th St to 33rd St",
        "fullDesc":
            "Road closed due to construction on Arkins Ct both ways from 35th St to 33rd St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.800000011920929,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "33rd St",
          "crossRoad1": "35th St / Arkins Ct / Chestnut Pl",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, construction",
          "roadName": "Arkins Ct"
        }
      },
      {
        "id": "116349401",
        "type": 1,
        "severity": 3,
        "eventCode": 702,
        "lat": 39.770805,
        "lng": -104.810242,
        "startTime": "2020-12-07T08:30:00",
        "endTime": "2020-12-07T15:31:00",
        "impacting": false,
        "shortDesc":
            "I-70: major construction between Exits 274,275A and Exits 284,285",
        "fullDesc":
            "Intermittent lane closures due to major construction on I-70 both ways between I-70 Exits 274,275A / US-6 / Washington St and I-70 Exits 282,283,284 / Chambers Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 29.030000686645508,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "I-70  Exits 282,283,284 / Chambers Rd",
          "crossRoad1": "I-70  Exits 274,275A / US-6 / Washington St",
          "position2": "and",
          "direction": "both ways",
          "position1": "between",
          "eventText": "Major Construction, intermittent Lane Closures",
          "fromLocation": "Denver",
          "toLocation": "Sable",
          "roadName": "I-70"
        }
      },
      {
        "id": "130197967",
        "type": 1,
        "severity": 1,
        "eventCode": 735,
        "lat": 39.77132,
        "lng": -104.968407,
        "startTime": "2019-12-31T07:00:00",
        "endTime": "2020-12-31T17:01:00",
        "impacting": false,
        "shortDesc": "39th Ave: road closed from High St to Franklin St",
        "fullDesc":
            "Road closed due to construction on 39th Ave both ways from High St to Franklin St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Franklin St / 39th Ave",
          "crossRoad1": "High St / 39th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, construction",
          "roadName": "39th Ave"
        }
      },
      {
        "id": "132968315",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.774307,
        "lng": -104.977203,
        "startTime": "2020-08-30T07:00:00",
        "endTime": "2021-12-30T17:01:00",
        "impacting": false,
        "shortDesc":
            "38th St: intermittent lane closures from Arkins Ct to Chestnut Pl",
        "fullDesc":
            "Intermittent lane closures due to construction on 38th St both ways from Arkins Ct to Chestnut Pl.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.20000000298023224,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "38th St / Chestnut Pl",
          "crossRoad1": "38th St / Arkins Ct",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Intermittent Lane Closures, construction",
          "roadName": "38th St"
        }
      },
      {
        "id": "128845729",
        "type": 1,
        "severity": 3,
        "eventCode": 406,
        "lat": 39.774841,
        "lng": -105.144867,
        "startTime": "2020-12-07T09:00:00",
        "endTime": "2020-12-07T15:01:00",
        "impacting": true,
        "shortDesc": "I-70 E/B: entry ramp from CO-58 E/B closed.",
        "fullDesc":
            "Entry ramp to I-70 Eastbound from CO-58 Eastbound closed due to construction during off-peak periods.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 1.7400000095367432,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "direction": "None",
          "position1": "at",
          "eventText":
              "Entry ramp closed, construction During Off-Peak Periods",
          "toLocation": "Mt Olivet",
          "roadName": "CO-58"
        }
      },
      {
        "id": "138251320",
        "type": 1,
        "severity": 2,
        "eventCode": 641,
        "lat": 39.778141,
        "lng": -105.109642,
        "startTime": "2020-12-07T04:20:55",
        "endTime": "2020-12-07T12:00:00",
        "impacting": false,
        "shortDesc": "CO-391 Kipling St: one lane closed near CO-51 44th Ave",
        "fullDesc":
            "One lane closed due to construction work on CO-391 Kipling St both ways near CO-51 44th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-391 Kipling St / CO-51 44th Ave",
          "direction": "both ways",
          "position1": "near",
          "eventText": "Lane (or Lanes) closed, construction work",
          "toLocation": "Kipling",
          "roadName": "CO-391"
        }
      },
      {
        "id": "131993130",
        "type": 1,
        "severity": 0,
        "eventCode": 735,
        "lat": 39.77861,
        "lng": -104.959419,
        "startTime": "2020-08-17T00:00:00",
        "endTime": "2021-03-17T00:00:00",
        "impacting": true,
        "shortDesc": "York St: road closed from 47th Ave to 45th Ave",
        "fullDesc":
            "Road closed due to construction on York St both ways from 47th Ave to 45th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.3700000047683716,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "York St / 45th Ave",
          "crossRoad1": "York St / 47th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, construction",
          "roadName": "York St"
        }
      },
      {
        "id": "84408429",
        "type": 1,
        "severity": 2,
        "eventCode": 702,
        "lat": 39.780025,
        "lng": -104.966927,
        "startTime": "2018-09-17T04:47:41",
        "endTime": "2021-02-28T23:59:00",
        "impacting": true,
        "shortDesc":
            "46th Ave: major Central I-70 Project construction from York St to Brighton Blvd",
        "fullDesc":
            "Road permanently closed due to major Central I-70 Project construction on 46th Ave both ways from York St to Brighton Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Brighton Blvd",
          "crossRoad1": "York St / 46th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Major Construction, road permanently closed",
          "roadName": "46th Ave"
        }
      },
      {
        "id": "131448933",
        "type": 1,
        "severity": 1,
        "eventCode": 735,
        "lat": 39.780071,
        "lng": -104.957085,
        "startTime": "2020-07-15T07:00:00",
        "endTime": "2021-08-17T17:01:00",
        "impacting": false,
        "shortDesc": "Columbine St: road closed from 47th Ave to 46th Ave",
        "fullDesc":
            "Road closed due to construction on Columbine St both ways from 47th Ave to 46th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "46th Ave / Columbine St",
          "crossRoad1": "47th Ave / Columbine St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, construction",
          "roadName": "Columbine St"
        }
      },
      {
        "id": "131424342",
        "type": 1,
        "severity": 0,
        "eventCode": 735,
        "lat": 39.780075,
        "lng": -104.959297,
        "startTime": "2020-08-17T00:00:00",
        "endTime": "2021-03-30T00:00:00",
        "impacting": true,
        "shortDesc": "York St: road closed between 47th Ave and 46th Ave",
        "fullDesc":
            "Road closed due to construction on York St both ways between 47th Ave and 46th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.20999999344348907,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "46th Ave",
          "crossRoad1": "York St / 47th Ave",
          "position2": "and",
          "direction": "both ways",
          "position1": "between",
          "eventText": "Road closed, construction",
          "roadName": "York St"
        }
      },
      {
        "id": "131448924",
        "type": 1,
        "severity": 1,
        "eventCode": 735,
        "lat": 39.780102,
        "lng": -104.95929,
        "startTime": "2020-08-17T07:00:00",
        "endTime": "2021-04-03T17:01:00",
        "impacting": true,
        "shortDesc": "York St S/B: road closed from 47th Ave to 46th Ave",
        "fullDesc":
            "Road closed due to construction on York St Southbound from 47th Ave to 46th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.20999999344348907,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "46th Ave",
          "crossRoad1": "York St / 47th Ave",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Road closed, construction",
          "roadName": "York St"
        }
      },
      {
        "id": "102264687",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.780128,
        "lng": -104.953537,
        "startTime": "2019-04-01T05:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": true,
        "shortDesc":
            "Vasquez Blvd Frontage Rd: construction from Milwaukee St to Clayton St",
        "fullDesc":
            "Road permanently closed due to construction on Vasquez Blvd Frontage Rd both ways from Milwaukee St / Vasquez Blvd to Vasquez Blvd / Clayton St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.30000001192092896,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Vasquez Blvd / Clayton St",
          "crossRoad1": "Milwaukee St / Vasquez Blvd",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, road permanently closed",
          "roadName": "Vasquez Blvd Frontage Rd"
        }
      },
      {
        "id": "138251169",
        "type": 1,
        "severity": 3,
        "eventCode": 701,
        "lat": 39.78014,
        "lng": -104.966927,
        "startTime": "2020-12-07T04:13:32",
        "endTime": "2020-12-07T12:30:00",
        "impacting": false,
        "shortDesc":
            "I-70: intermittent lane closures from Chambers Rd to CO-265 Brighton Blvd",
        "fullDesc":
            "Intermittent lane closures due to construction work on I-70 both ways from Chambers Rd to CO-265 Brighton Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 26.969999313354492,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-265 Brighton Blvd",
          "crossRoad1": "Chambers Rd",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Intermittent Lane Closures, construction work",
          "fromLocation": "Peterson",
          "toLocation": "Elyria Swansea",
          "roadName": "I-70"
        }
      },
      {
        "id": "136553342",
        "type": 1,
        "severity": 3,
        "eventCode": 407,
        "lat": 39.78014,
        "lng": -104.96328,
        "startTime": "2020-12-01T06:00:00",
        "endTime": "2021-07-01T06:00:00",
        "impacting": true,
        "shortDesc": "I-70 W/B: exit ramp to Brighton Blvd closed.",
        "fullDesc":
            "Exit ramp from I-70 Westbound to Brighton Blvd closed due to long-term construction.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.8700000047683716,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "direction": "None",
          "position1": "at",
          "eventText": "Exit ramp closed, long-Term Construction",
          "toLocation": "Elyria Swansea",
          "roadName": "I-70 "
        }
      },
      {
        "id": "130272786",
        "type": 1,
        "severity": 3,
        "eventCode": 701,
        "lat": 39.780312,
        "lng": -104.936287,
        "startTime": "2020-06-12T18:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": true,
        "shortDesc": "I-70 W/B: entry ramp from Stapleton Dr W/B construction.",
        "fullDesc":
            "Construction and permanently closed on entry ramp to I-70 Westbound from Stapleton Dr Westbound.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.27000001072883606,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "E 46th Ave / I-70",
          "direction": "None",
          "position1": "at",
          "eventText": "Construction, entry Ramp Permanently Closed",
          "toLocation": "Northeast Park Hill",
          "roadName": "Stapleton Dr N"
        }
      },
      {
        "id": "132646062",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.780331,
        "lng": -104.951927,
        "startTime": "2020-09-08T05:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": false,
        "shortDesc": "I-70 W/B: entry ramp from Steele St construction.",
        "fullDesc":
            "Entry ramp to I-70 Westbound from Steele St restrictions on entry ramp due to construction. Loop ramp from 46th Ave permanently closed.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.8700000047683716,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Steele St / I-70",
          "direction": "None",
          "position1": "at",
          "eventText": "Construction, restrictions on entry ramp",
          "toLocation": "Elyria Swansea",
          "roadName": "Steele St"
        }
      },
      {
        "id": "115447654",
        "type": 1,
        "severity": 2,
        "eventCode": 702,
        "lat": 39.780472,
        "lng": -104.93734,
        "startTime": "2019-08-21T07:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": true,
        "shortDesc":
            "46th Ave S/B: major I-70 Central Project from 48th Ave to Stapleton Dr N",
        "fullDesc":
            "Road permanently closed due to major I-70 Central Project on 46th Ave Southbound from 48th Ave to Stapleton Dr N.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "Stapleton Dr N",
          "crossRoad1": "48th Ave",
          "position2": "to",
          "direction": "Southbound",
          "position1": "from",
          "eventText": "Major Construction, road permanently closed",
          "roadName": "46th Ave"
        }
      },
      {
        "id": "130718412",
        "type": 1,
        "severity": 3,
        "eventCode": 701,
        "lat": 39.780491,
        "lng": -104.948753,
        "startTime": "2020-06-26T22:00:00",
        "endTime": "2020-12-31T23:59:00",
        "impacting": true,
        "shortDesc": "I-70 W/B: exit ramp to Steele St construction.",
        "fullDesc":
            "Construction and permanently closed on exit ramp from I-70 Westbound at Exit 276A to Steele St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.4300000071525574,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "I-70 / Steele St",
          "direction": "None",
          "position1": "at",
          "eventText": "Construction, exit ramp permanently closed",
          "toLocation": "Elyria Swansea",
          "roadName": "I-70"
        }
      },
      {
        "id": "135034256",
        "type": 1,
        "severity": 3,
        "eventCode": 406,
        "lat": 39.781151,
        "lng": -104.949989,
        "startTime": "2020-11-09T06:00:00",
        "endTime": "2021-06-01T06:00:00",
        "impacting": true,
        "shortDesc": "I-70 W/B: entry ramp from Steele St closed.",
        "fullDesc":
            "Entry ramp to I-70 Westbound from Steele St closed due to long-term construction.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.8700000047683716,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "direction": "None",
          "position1": "at",
          "eventText": "Entry ramp closed, long-Term Construction",
          "toLocation": "Elyria Swansea",
          "roadName": "Steele St"
        }
      },
      {
        "id": "125829926",
        "type": 1,
        "severity": 1,
        "eventCode": 701,
        "lat": 39.782494,
        "lng": -104.940613,
        "startTime": "2018-12-31T07:00:00",
        "endTime": "2020-12-31T17:01:00",
        "impacting": false,
        "shortDesc": "48th Ave: construction from Colorado Blvd to 46th Ave",
        "fullDesc":
            "Road permanently closed due to construction on 48th Ave both ways from Colorado Blvd to 46th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.20000000298023224,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "46th Ave",
          "crossRoad1": "Colorado Blvd ",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction, road permanently closed",
          "roadName": "48th Ave"
        }
      },
      {
        "id": "131652079",
        "type": 1,
        "severity": 0,
        "eventCode": 815,
        "lat": 39.784168,
        "lng": -105.10952,
        "startTime": "2020-12-07T07:30:00",
        "endTime": "2020-12-07T17:01:00",
        "impacting": false,
        "shortDesc":
            "CO-391: construction during the day time at I-70 Exit 267",
        "fullDesc":
            "Construction during the day time on CO-391 both ways at I-70 Exit 267.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "I-70  Exit 267 / CO-391 / CO-391 Kipling St",
          "direction": "both ways",
          "position1": "at",
          "eventText": "Construction during the day time",
          "toLocation": "Garrison Lakes",
          "roadName": "CO-391"
        }
      },
      {
        "id": "131223016",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.784538,
        "lng": -105.114311,
        "startTime": "2020-12-07T07:00:00",
        "endTime": "2020-12-07T17:31:00",
        "impacting": false,
        "shortDesc":
            "I-70 Frontage Rd: intermittent lane closures from CO-391 to Miller St",
        "fullDesc":
            "Intermittent lane closures due to construction during the day time on I-70 Frontage Rd both ways from CO-391 Kipling St / I-70 Frontage Rd / 49th Ave to Miller St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.8899999856948853,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Miller St / I-70 Frontage Rd",
          "crossRoad1": "CO-391 Kipling St / I-70 Frontage Rd / 49th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, construction during the day time",
          "roadName": "I-70 Frontage Rd"
        }
      },
      {
        "id": "131223015",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.787022,
        "lng": -105.109703,
        "startTime": "2020-12-07T07:00:00",
        "endTime": "2020-12-07T17:31:00",
        "impacting": false,
        "shortDesc":
            "50th Ave: intermittent lane closures at CO-391 Kipling St",
        "fullDesc":
            "Intermittent lane closures due to construction during the day time on 50th Ave both ways at CO-391 Kipling St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-391 Kipling St / 50th Ave",
          "direction": "both ways",
          "position1": "at",
          "eventText":
              "Intermittent Lane Closures, construction during the day time",
          "toLocation": "Garrison Lakes",
          "roadName": "50th Ave"
        }
      },
      {
        "id": "131223014",
        "type": 1,
        "severity": 2,
        "eventCode": 701,
        "lat": 39.787022,
        "lng": -105.109467,
        "startTime": "2020-12-07T07:00:00",
        "endTime": "2020-12-07T17:31:00",
        "impacting": false,
        "shortDesc":
            "CO-391 Kipling St: intermittent lane closures from I-70 Service Rd to 50th Ave",
        "fullDesc":
            "Intermittent lane closures due to construction during the day time on CO-391 Kipling St both ways from I-70 Service Rd to 50th Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.9200000166893005,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CO-391 Kipling St / 50th Ave",
          "crossRoad1": "CO-391 Kipling St / I-70 Service Rd",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, construction during the day time",
          "fromLocation": "Kipling",
          "toLocation": "Garrison Lakes",
          "roadName": "CO-391"
        }
      },
      {
        "id": "132927437",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.791088,
        "lng": -105.023941,
        "startTime": "2020-08-07T07:00:00",
        "endTime": "2020-12-17T17:01:00",
        "impacting": false,
        "shortDesc": "52nd Ave: construction from Elm Ct to Eliot St",
        "fullDesc":
            "Construction on 52nd Ave both ways from Elm Ct to Eliot St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.20000000298023224,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "52nd Ave / Eliot St",
          "crossRoad1": "52nd Ave / Elm Ct",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Construction",
          "roadName": "52nd Ave"
        }
      },
      {
        "id": "135954918",
        "type": 1,
        "severity": 2,
        "eventCode": 517,
        "lat": 39.798489,
        "lng": -105.174637,
        "startTime": "2020-11-02T06:00:00",
        "endTime": "2020-12-30T06:00:00",
        "impacting": false,
        "shortDesc":
            "CR-15 Mcintyre St N/B: Main roadway closed from CR-344 52nd Ave to 56th Pl",
        "fullDesc":
            "Main roadway closed and traffic shift on CR-15 Mcintyre St Northbound from CR-344 52nd Ave to 56th Pl. Detour in operation - All traffic moved to the SB lanes.",
        "delayFromFreeFlow": 0.11999999731779099,
        "delayFromTypical": 0.0,
        "distance": 0.8600000143051147,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_mod.png",
        "parameterizedDescription": {
          "crossRoad2": "CR-15 Mcintyre St / 56th Pl",
          "crossRoad1": "CR-15 Mcintyre St / CR-344 52nd Ave",
          "position2": "to",
          "direction": "Northbound",
          "position1": "from",
          "eventText":
              "Main roadway closed, traffic Shift, detour in operation",
          "roadName": "CR-15"
        }
      },
      {
        "id": "130253410",
        "type": 1,
        "severity": 1,
        "eventCode": 401,
        "lat": 39.799149,
        "lng": -105.081467,
        "startTime": "2020-06-12T15:00:00",
        "endTime": "2021-06-14T20:00:00",
        "impacting": false,
        "shortDesc":
            "Grandview Ave: road closed from Webster St to Olde Wadsworth Blvd",
        "fullDesc":
            "Road closed due to Safe Streets on Grandview Ave both ways from Webster St / Grandview Ave to Grandview Ave / Olde Wadsworth Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Grandview Ave / Olde Wadsworth Blvd",
          "crossRoad1": "Webster St / Grandview Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, other",
          "roadName": "Grandview Ave"
        }
      },
      {
        "id": "130253416",
        "type": 1,
        "severity": 1,
        "eventCode": 401,
        "lat": 39.801128,
        "lng": -105.081459,
        "startTime": "2020-06-12T15:00:00",
        "endTime": "2021-06-14T15:00:00",
        "impacting": true,
        "shortDesc":
            "Olde Wadsworth Blvd: road closed from Grandview Ave to Grant Pl",
        "fullDesc":
            "Road closed due to Safe Streets on Olde Wadsworth Blvd both ways from Grandview Ave / Olde Wadsworth Blvd to Grant Pl / Olde Wadsworth Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.4399999976158142,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Grant Pl / Olde Wadsworth Blvd",
          "crossRoad1": "Grandview Ave / Olde Wadsworth Blvd",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText": "Road closed, other",
          "roadName": "Olde Wadsworth Blvd"
        }
      },
      {
        "id": "124797433",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.805618,
        "lng": -105.104912,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Brooks Dr E/B: intermittent lane closures from Johnson Way to Independence St",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on Brooks Dr Eastbound from Johnson Way to Independence St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Independence St / Brooks Dr",
          "crossRoad1": "Johnson Way / Brooks Dr",
          "position2": "to",
          "direction": "Eastbound",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "Brooks Dr"
        }
      },
      {
        "id": "124797432",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.806568,
        "lng": -105.106857,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Johnson Way: intermittent lane closures from Brooks Dr to Brooks Dr",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on Johnson Way both ways from Brooks Dr to Brooks Dr.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Brooks Dr ",
          "crossRoad1": "Brooks Dr / Johnson Way",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "Johnson Way"
        }
      },
      {
        "id": "124797421",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.81131,
        "lng": -105.113449,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Ralston Rd: intermittent lane closures from Miller St to Brooks Dr",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on Ralston Rd both ways from Miller St to Brooks Dr.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.25999999046325684,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Ralston Rd / Brooks Dr",
          "crossRoad1": "Ralston Rd / Miller St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "Ralston Rd"
        }
      },
      {
        "id": "124797422",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.81168,
        "lng": -105.112846,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Brooks Dr: intermittent lane closures from Ralston Rd to Johnson Way",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on Brooks Dr both ways from Ralston Rd to Johnson Way.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Brooks Dr / Johnson Way",
          "crossRoad1": "Ralston Rd / Brooks Dr",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "Brooks Dr"
        }
      },
      {
        "id": "124797418",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.81218,
        "lng": -105.114471,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Miller St: intermittent lane closures from 65th Ave to Ralston Rd",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on Miller St both ways from 65th Ave to Ralston Rd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Ralston Rd / Miller St",
          "crossRoad1": "Miller St / 65th Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "Miller St"
        }
      },
      {
        "id": "124797412",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.8167,
        "lng": -105.119011,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "Oak St: intermittent lane closures from 69th Ave to 65th Way",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on Oak St both ways from 69th Ave to 65th Way.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Oak St / 65th Way",
          "crossRoad1": "69th Ave / Oak St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "Oak St"
        }
      },
      {
        "id": "124797410",
        "type": 1,
        "severity": 0,
        "eventCode": 701,
        "lat": 39.82185,
        "lng": -105.11908,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "69th Ave: intermittent lane closures from Parfet St to Oak St",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on 69th Ave both ways from Parfet St to Oak St.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "69th Ave / Oak St",
          "crossRoad1": "69th Ave / Parfet St",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "69th Ave"
        }
      },
      {
        "id": "124796654",
        "type": 1,
        "severity": 1,
        "eventCode": 701,
        "lat": 39.824051,
        "lng": -105.128479,
        "startTime": "2020-01-27T07:00:00",
        "endTime": "2021-01-31T17:01:00",
        "impacting": false,
        "shortDesc":
            "CR-19 Simms St: intermittent lane closures from CR-194 72nd Ave to 71st Ave",
        "fullDesc":
            "Intermittent lane closures and parking restrictions in force due to sewer works on CR-19 Simms St both ways from CR-194 72nd Ave to 71st Ave.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.6600000262260437,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "CR-19 Simms St / 71st Ave",
          "crossRoad1": "CR-19 Simms St / CR-194 72nd Ave",
          "position2": "to",
          "direction": "both ways",
          "position1": "from",
          "eventText":
              "Intermittent Lane Closures, sewer Works, parking Restrictions In Force",
          "roadName": "CR-19 Simms St"
        }
      },
      {
        "id": "138089915",
        "type": 1,
        "severity": 0,
        "eventCode": 641,
        "lat": 39.928539,
        "lng": -105.015503,
        "startTime": "2020-12-07T00:00:00",
        "endTime": "2020-12-10T23:59:00",
        "impacting": false,
        "shortDesc": "Zuni St S/B: one lane closed before Midway Blvd",
        "fullDesc":
            "One lane closed due to utility work on Zuni St Southbound before Midway Blvd.",
        "delayFromFreeFlow": 0.0,
        "delayFromTypical": 0.0,
        "distance": 0.0,
        "iconURL": "http://content.mqcdn.com/mqtraffic/const_min.png",
        "parameterizedDescription": {
          "crossRoad2": "Midway Blvd",
          "direction": "Southbound",
          "position1": "before",
          "eventText": "Lane (or Lanes) closed, utility Work",
          "toLocation": "North Westminster",
          "roadName": "Zuni St"
        }
      }
    ],
    "mqUrl":
        "http://www.mapquest.com/maps?traffic=1&latitude=39.735&longitude=-104.97999999999999",
    "info": {
      "copyright": {
        "text": "© 2020 MapQuest, Inc.",
        "imageUrl": "https://api-s.mqcdn.com/res/mqlogo.gif",
        "imageAltText": "© 2020 MapQuest, Inc."
      },
      "messages": [],
      "statuscode": 0
    }
  };
}
