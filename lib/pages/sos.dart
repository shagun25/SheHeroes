import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:safety/shared/constants.dart';
import 'package:safety/shared/widgets/bottom_bar.dart';
import 'package:safety/shared/widgets/gradient.dart';
import 'package:safety/shared/widgets/round_app_bar.dart';
import 'package:safety/shared/widgets/sos_button.dart';

class SOSPage extends StatelessWidget {
  static final String route = '/sosPage';
  @override
  Widget build(BuildContext context) {
    // final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          RoundedAppBar(
            // child: Text('Hi'),
            margin: 8,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 1,
                  child: GradientWidget(
                    gradient: Gradients.sosGradient,
                    child: Text(
                      'KEEP CALM!',
                      style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Flexible(
                  child: Text(
                    'Notified 2 people, 1 person coming',
                    style: TextStyle(
                      // fontSize: 25,

                      color: Colors.black,

                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 35,
                // ),
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 6,
                  child: SOSButton(
                    startColor: Gradients.startColor,
                    endColor: Gradients.endColor,
                    fromEmergency: false,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('Emergency_Dashboard', (Route<dynamic> route) => false);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SOS',
                          style: TextStyle(color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Press to notify others for help',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned.fill(
          //     child: profileProvider.isProfileOpened == true
          //         ? Container(
          //             color: Colors.black38,
          //           )
          //         : SizedBox())
        ],
      ),
      bottomNavigationBar: BottomTimeBar(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 100,
          decoration: BoxDecoration(
            // border: Border.all(width: 1),
            color: Colors.white,
          ),
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: Constants.policeStaionFunction,
            child: GradientWidget(
              gradient: Gradients.sosGradient,
              child: AlignPositioned(
                moveByContainerHeight: 0.08,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_alert,
                      color: Colors.white,
                    ),
                    Text(
                      'Find Nearest Police Station',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
