import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;
import 'package:provider/provider.dart';
import 'package:safety/pages/AR.dart';
import 'package:safety/pages/Voice.dart';
import 'package:safety/pages/center_map.dart';
import 'package:safety/pages/emergency_dashboard.dart';
import 'package:safety/pages/emergency_map.dart';
import 'package:safety/pages/emergency_people_list.dart';
import 'package:safety/pages/main_dashboard.dart';
import 'package:safety/pages/photo_capture.dart';
import 'package:safety/pages/sos.dart';
import 'package:safety/pages/switcher.dart';
import 'package:safety/providers/profile_provider.dart';
import 'package:safety/services/service_locator.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/ui/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _latestHardwareButtonEvent;

  StreamSubscription<HardwareButtons.VolumeButtonEvent>
      _volumeButtonSubscription;

  StreamSubscription<HardwareButtons.HomeButtonEvent> _homeButtonSubscription;

  StreamSubscription<HardwareButtons.LockButtonEvent> _lockButtonSubscription;

  @override
  void initState() {
    super.initState();
    _volumeButtonSubscription =
        HardwareButtons.volumeButtonEvents.listen((event) {
      setState(() {
        // _latestHardwareButtonEvent = event.toString();
        Constants.sendMessage();
      });
    });

    _homeButtonSubscription = HardwareButtons.homeButtonEvents.listen((event) {
      setState(() {
        // _latestHardwareButtonEvent = 'HOME_BUTTON';
        Constants.sendMessage();
      });
    });

    _lockButtonSubscription = HardwareButtons.lockButtonEvents.listen((event) {
      setState(() {
        // _latestHardwareButtonEvent = 'LOCK_BUTTON';
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PhotoCapture()));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _volumeButtonSubscription?.cancel();
    _homeButtonSubscription?.cancel();
    _lockButtonSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (BuildContext context) {
        return ProfileProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SheHeroes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => Splash(),
          'Switcher': (context) => Switcher(),
          'sos': (context) => SOSPage(),
          'Safe_Dashboard': (context) => MainDashboard(),
          'Emergency_Dashboard': (context) => Hom(),
          // 'Defense': (context) => self(),
          // 'Strategy': (context) => EmergencyInfoPage(),
          'AR': (context) => ARDetectionPage(),
          'Shake': (context) => PhotoCapture(),
          'Emergency_List': (_) => EmergencyPeopleList(),
          'Emergency_Map': (_) => MyHomePage(),
          'center_map': (_) => HomePage(),
          'voice': (_) => SpeechScreen(),
        },
      ),
    );
  }
}
