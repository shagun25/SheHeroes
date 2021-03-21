import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;
import 'package:provider/provider.dart';
import 'package:safety/pages/photo_capture.dart';
import 'package:safety/providers/profile_provider.dart';
import 'package:safety/services/service_locator.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/ui/splash.dart';
import 'package:safety/utils/routes.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialise HiveDB in the directory of the app
  Directory appDocDir = await path.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  
  // await Firebase.initializeApp();
  await Firebase.initializeApp();
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
        Navigator.pushNamed(context, PhotoCapture.route);
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
        routes: Routes().getRoutes(),
        navigatorKey: appNavigator.navigatorKey,
        home: Splash(),
      ),
    );
  }
}
