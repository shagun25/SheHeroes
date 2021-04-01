import 'dart:math';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety/pages/emergency_people_list.dart';
import 'package:safety/providers/profile_provider.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/shared/widgets/bottom_bar.dart';
import 'package:safety/shared/widgets/circular_button.dart';
import 'package:safety/shared/widgets/drawer.dart';
import 'package:safety/shared/widgets/gradient.dart';
import 'package:safety/shared/widgets/profile_card.dart';
import 'package:safety/shared/widgets/round_app_bar.dart';

class MainDashboard extends StatefulWidget {
  static final String route = '/mainDashboard';
  // static AudioCache player = AudioCache();

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
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
    // FlutterIntroductionTooltip.showBottomTutorialOnWidget(
    // context, key, Colors.red, () {}, 'Hi', 'subtitle', 'Close');
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xfff6f8f8),
      drawer: Drawer_zoom(context),
      body: Stack(
        // mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: GradientWidget(
                  gradient: Gradients.dashboardButtonGradient,
                  child: Text(
                    'SELECT AN OPTION',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:

                      ///`Buttons`
                      Wrap(
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      CircularButtonDashboard(
                        icon: Constants.sosIcon,
                        text: 'SOS',
                        onPressed: () => Navigator.of(context).pushNamed('sos'),
                      ),
                      CircularButtonDashboard(
                        icon: Constants.policeIcon,
                        text: 'Police Stations',
                        onPressed: Constants.policeStaionFunction,
                      ),
                      CircularButtonDashboard(
                        icon: Constants.taxiIcon,
                        text: 'Taxi/Cab',
                        onPressed: Constants.taxiButton,
                      ),
                      CircularButtonDashboard(
                        icon: Constants.selfDefenseIcon,
                        text: 'Self Defense',
                        onPressed: () => Navigator.of(context).pushNamed('Defense'),
                      ),
                      CircularButtonDashboard(
                        icon: Constants.arIcon,
                        text: 'AR Detection',
                        onPressed: () => Navigator.of(context).pushNamed('AR'),
                      ),
                      CircularButtonDashboard(
                        icon: Constants.sirenIcon,
                        text: 'Play Siren',
                        onPressed: () {
                          try {
                            // MainDashboard.player.clearCache();
                            // MainDashboard.player.play('siren.mp3');
                          // ignore: empty_catches
                          } catch (e) {}
                          Gradients.showMyDialog(
                            context,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RotationTransition(
                                  turns: Tween(begin: 0.0, end: -.1)
                                      .chain(CurveTween(curve: Curves.elasticIn))
                                      .animate(_animationController),
                                  child: Icon(Icons.notifications_active, size: 70, color: Color(0xffffc400)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Playing Siren\n\n Tap to play again',
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
                            () {
                              try {
                                // MainDashboard.player.clearCache();
                                // MainDashboard.player.play('siren.mp3');
                              // ignore: empty_catches
                              } catch (e) {}
                            },
                          );
                          _runAnimation();
                        },
                      ),
                      CircularButtonDashboard(
                        icon: Constants.firIcon,
                        text: 'FIR',
                        onPressed: () async {
                          await Navigator.of(context).pushNamed('Emergency_List');
                          // List<Placemark> placemark = await Geolocator()
                          //     .placemarkFromCoordinates(28.686503, 77.364235);
                          // print(placemark[0].subLocality);
                        },
                      ),
                      CircularButtonDashboard(
                        icon: Constants.shakeIcon,
                        text: 'Shake',
                        onPressed: () {
                          Gradients.showMyDialog(
                            context,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShakeAnimatedWidget(
                                  enabled: true,
                                  duration: Duration(milliseconds: 300),
                                  shakeAngle: Rotation.deg(z: 5),
                                  curve: Curves.linear,
                                  child: Transform.rotate(
                                    angle: (pi / 180) * -35,
                                    child: Icon(Constants.shakeIcon, size: 70, color: Color(0xffffc400)),
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
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionTile(
                title: Text('People in Emergency!'),
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        PersonTileEmergency(
                          name: 'Mason Garcia',
                          distance: 700,
                          minutes: 5,
                        ),
                        PersonTileEmergency(
                          name: 'Kristen Aadland',
                          distance: 500,
                          minutes: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          RoundedAppBar(
            margin: 8,
          ),
          Positioned.fill(
            child: profileProvider.isProfileOpened == true
                ? GestureDetector(
                    onTap: () {
                      print('ahebf');
                      profileProvider.closeProfile();
                    },
                    child: Container(
                      color: Colors.black38,
                      constraints: BoxConstraints.expand(),
                    ),
                  )
                : SizedBox(),
          ),
          Positioned(right: 0, top: 0, child: ProfileCard()),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomTimeBar(
            child: Container(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(253, 137, 1, 1),
                          Color.fromRGBO(244, 102, 65, 1),
                        ]),
                        color: Color(0xffe72d88),
                        border: Border.all(width: 1)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('5 min 10 s', style: TextStyle(color: Colors.white, fontSize: 24)),
                          Text('Time to reach',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              stops: [0.6, 1], colors: [Color.fromRGBO(244, 102, 65, 1), Color.fromRGBO(253, 137, 1, 1)]),
                          color: Colors.red),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('252m', style: TextStyle(color: Colors.white, fontSize: 24)),
                                Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Text('Distance from you',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // color: Colors.red,
            ),
          ),
          profileProvider.isProfileOpened == true
              ? Positioned.fill(
                  child: GestureDetector(
                  onTap: () {
                    print('Closing');
                    profileProvider.closeProfile();
                  },
                  child: Container(
                    color: Colors.black38,
                  ),
                ))
              : SizedBox()
        ],
      ),
    );
  }
}
