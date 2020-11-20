import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:safety/services/shake.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';

class Gradients {
  static ShakeDetector detector;
  static Color startColor = Colors.redAccent[400];
  static Color endColor = Color(0xffe72d88);

  static LinearGradient dashboardButtonGradient = LinearGradient(

      // stops: [0.1, 1],

      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.redAccent[400], Color(0xffe72d88)]);

  static const LinearGradient sosGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    // stops: [0.5, 1],
    // center: Alignment.topLeft,
    // radius: 0.5,
    colors: <Color>[Colors.redAccent, Color(0xffe72f8b)],
    tileMode: TileMode.repeated,
  );

  static const Color mainColor = Color(0xffff9100);

  static void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  static Future<Position> _getCurrentPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  static Function(BuildContext, Widget, Function) showMyDialog =
      (BuildContext context, Widget child, Function onPressed) =>
          showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (context, a1, a2, widget) {
                Constants.listenShake();
                return WillPopScope(
                  onWillPop: () {},
                  child: Transform.scale(
                    scale: a1.value,
                    child: Opacity(
                      opacity: a1.value,
                      child: AlertDialog(
                        backgroundColor: Colors.transparent,
                        shape: CircleBorder(
                            // side: BorderSide(width: 0),
                            ),
                        // title: Text('Hello!!'),
                        content: Container(
                          padding: EdgeInsets.all(20),

                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(253, 137, 1, 0.65)),

                          // duration: Duration(seconds: 1),

                          child: Container(
                            constraints:
                                BoxConstraints.tight(Size.fromRadius(300)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              // gradient: LinearGradient(

                              //     // stops: [0.1, 1],

                              //     begin: Alignment.topLeft,
                              //     end: Alignment.bottomRight,
                              //     colors: [
                              //       Colors.redAccent[400],
                              //       Color(0xffe72d88)
                              //     ]),
                            ),
                            child: FlatButton(
                                shape: CircleBorder(),
                                onPressed: onPressed,
                                child: child),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 200),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {});
}

class Constants {
  static IconData policeIcon = Icons.control_point_duplicate;
  static IconData sosIcon = Icons.scanner;
  static IconData arIcon = Icons.panorama_fish_eye;
  static IconData shakeIcon = Icons.vibration;
  static IconData selfDefenseIcon = Icons.perm_device_information;
  static IconData sirenIcon = Icons.notification_important;
  static IconData taxiIcon = Icons.local_taxi;
  static IconData firIcon = Icons.find_in_page;

  static Function taxiButton = () async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final url = "http://book.olacabs.com/?lat=" +
        position.latitude.toString() +
        "&lng=" +
        position.longitude.toString() +
        "&category=compact&utm_source=12343&drop_lat=28682640&drop_lng=77.370486&dsw=yes";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  };
  static Function policeStaionFunction = () async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    String s = MapsLauncher.createCoordinatesUrl(
        position.latitude, position.longitude);
    MapsLauncher.launchQuery('police station');

    // MapsLauncher.launchQuery(
    //     '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA');
  };

  static Function listenShake = () {
    Gradients.detector = ShakeDetector.autoStart(
      shakeThresholdGravity: 4.0,
      onPhoneShake: () {
        sendMessage();
      },
    );
  };

  static Function sendMessage = () async {
    Position position = await Gradients._getCurrentPosition();
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    String message =
        "Help! I'm in an emergency. I'm at (${first.featureName}, ${first.addressLine}).";
    List<String> recipents = ["8920532416"];

    Gradients._sendSMS(message, recipents);
  };
}
