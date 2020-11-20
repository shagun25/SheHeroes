import 'package:camera/new/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider with ChangeNotifier {
  final CameraDescription camera;
  CameraProvider(this.camera);
}
