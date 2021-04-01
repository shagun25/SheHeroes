import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:blobs/blobs.dart';
import 'package:flash_animation/flash_animation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safety/pages/emergency_dashboard.dart';

class CameraSwitcher extends StatefulWidget {
  @override
  _CameraSwitcherState createState() => _CameraSwitcherState();
}

class _CameraSwitcherState extends State<CameraSwitcher> {
  final FlashAnimation anim = FlashAnimation(
    gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
    child: SizedBox(
      width: 0.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    String firstButtonText = 'Take photo';
    String secondButtonText = 'Record video';
    double textSize = 20;
    String albumName = 'Media';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [HexColor('#FFC3CF'), HexColor('#F7BB97')])),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
              ),

              FlatButton(
                onPressed: () {
                  ImagePicker.pickImage(source: ImageSource.camera).then((File recordedImage) {
                    if (recordedImage != null && recordedImage.path != null) {
                      setState(() {
                        firstButtonText = 'saving in progress...';
                      });
                      GallerySaver.saveImage(recordedImage.path, albumName: albumName).then((bool success) {
                        setState(() {
                          firstButtonText = 'image saved!';
                        });
                      });
                    }
                  });
                },
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width / 15, 0, 0),
                        child: AvatarGlow(
                          endRadius: 130.0,
                          glowColor: Colors.blueAccent,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Blob.animatedRandom(
                        size: 295,
                        edgesCount: 5,
                        minGrowth: 4,
                        loop: true,
                        styles: BlobStyles(
                          color: Colors.blueAccent[100],
                          fillType: BlobFillType.fill,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width / 3.5, 0, 0),
                            child: Icon(Icons.camera_alt))),
                  ],
                ),
              ),
              // Expanded(
              //   child: Center(
              //     child: SOSButton(
              //       fromEmergency: false,
              //       startColor: Colors.blue,
              //       endColor: Colors.blue,
              //       child: Center(
              //         child: AutoSizeText(
              //           'Safe',
              //           style: TextStyle(color: Colors.white, fontSize: 40),
              //           maxLines: 1,
              //         ),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context)
              //             .pushReplacementNamed('Safe_Dashboard');
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              // Expanded(
              //   child: Center(
              //     child: SOSButton(
              //       fromEmergency: false,
              //       startColor: Colors.redAccent[400],
              //       endColor: Colors.deepOrange,
              //       child: Center(
              //         child: AutoSizeText(
              //           'Emergency',
              //           style: TextStyle(color: Colors.white, fontSize: 50),
              //           maxLines: 1,
              //         ),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context)
              //             .pushReplacementNamed('Emergency_Dashboard');
              //       },
              //     ),
              //   ),
              // ),

              FlatButton(
                autofocus: false,
                onPressed: () {
                  Navigator.pushNamed(context, Hom.route);
                },
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width / 15, 0, 0),
                        child: AvatarGlow(
                          endRadius: 130.0,
                          glowColor: Colors.deepOrange,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Blob.animatedRandom(
                        size: 295,
                        edgesCount: 5,
                        minGrowth: 4,
                        loop: true,
                        styles: BlobStyles(
                          color: Colors.deepOrange[300],
                          fillType: BlobFillType.fill,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.width / 3.5, 0, 0),
                            child: Icon(Icons.video_call))),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
