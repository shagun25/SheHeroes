import 'package:flutter/material.dart';
import 'package:safety/pages/AR.dart';
import 'package:safety/pages/Voice.dart';
import 'package:safety/pages/center_map.dart';
import 'package:safety/pages/emergency_dashboard.dart';
import 'package:safety/pages/emergency_map.dart';
import 'package:safety/pages/emergency_people_list.dart';
import 'package:safety/pages/main_dashboard.dart';
import 'package:safety/pages/nearby_places.dart';
import 'package:safety/pages/photo_capture.dart';
import 'package:safety/pages/sos.dart';
import 'package:safety/pages/switcher.dart';
import 'package:safety/ui/splash.dart';

class Routes {
  /// map of all screens
  static final _routes = <String, WidgetBuilder>{
    Splash.route: (BuildContext context) => Splash(),
    Switcher.route: (BuildContext context) => Switcher(),
    SOSPage.route: (BuildContext context) => SOSPage(),
    MainDashboard.route: (BuildContext context) => MainDashboard(),
    Hom.route: (BuildContext context) => Hom(),
    ARDetectionPage.route: (BuildContext context) => ARDetectionPage(),
    PhotoCapture.route: (BuildContext context) => PhotoCapture(),
    EmergencyPeopleList.route: (BuildContext context) => EmergencyPeopleList(),
    MyHomePage.route: (BuildContext context) => MyHomePage(),
    HomePage.route: (BuildContext context) => HomePage(),
    SpeechScreen.route: (BuildContext context) => SpeechScreen(),
    NearbyPlaces.route: (BuildContext context) => NearbyPlaces(),
  };

  Map<String, WidgetBuilder> getRoutes() {
    return _routes;
  }
}
