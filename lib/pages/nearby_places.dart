import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safety/pages/materialButton.dart';
import 'package:safety/shared/constants.dart';

import 'materialButton.dart';

class NearbyPlaces extends StatelessWidget {
  static final String route = '/nearbyPlaces';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xfffcbeac),
        appBar: AppBar(title: Text("Nearby Places"), backgroundColor: Color(0xffb72334), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButtonX(
                message: "Police",
                height: 70.0,
                width: 250.0,
                color: Color(0xffb72334),
                icon: Icons.local_police,
                iconSize: 40.0,
                radius: 56.0,
                onClick: () {
                  // ignore: unnecessary_statements
                  Constants.policeStaionFunction();
                },
              ),
              MaterialButtonX(
                message: "NGO",
                height: 70.0,
                width: 250.0,
                color: Color(0xffb72334),
                icon: FontAwesomeIcons.building,
                iconSize: 40.0,
                radius: 56.0,
                onClick: () {
                  Constants.ngoFunction();
                },
              ),
              MaterialButtonX(
                message: "Hospitals",
                height: 70.0,
                width: 250.0,
                color: Color(0xffb72334),
                icon: Icons.local_hospital,
                iconSize: 40.0,
                radius: 56.0,
                onClick: () {
                  Constants.hospitalFunction();
                },
              ),
              MaterialButtonX(
                message: "Public Parking",
                height: 70.0,
                width: 250.0,
                color: Color(0xffb72334),
                icon: Icons.local_parking,
                iconSize: 45.0,
                radius: 56.0,
                onClick: () {
                  Constants.publicParkingAreasFunction();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
