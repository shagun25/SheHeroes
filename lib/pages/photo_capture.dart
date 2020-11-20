import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoCapture extends StatefulWidget {
  PhotoCapture();

  @override
  _PhotoCaptureState createState() => _PhotoCaptureState();
}

class _PhotoCaptureState extends State<PhotoCapture> {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  // 1, 2
  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    // 3
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    // 4
    controller.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      // _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        // setState(() {
        // 2
        selectedCameraIdx = 0;
        // });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {
          _onCapturePressed(context);
        });
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  Widget _cameraTogglesRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: _onSwitchCamera,
            icon: Icon(_getCameraLensIcon(lensDirection)),
            label: Text(
                "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  void _onCapturePressed(context) async {
    try {
      // 1
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      // 2
      await controller.takePicture(path);
      // 3

      //get file here
      setState(() {
        imagePath = path;
        //  launch(
        //  "https://wa.me/${number}?text=Hello")
      });

      // getBytesFromFile(path).then((bytes) {
      //   // Share.file('Share via:', basename(widget.imagePath),
      //   //     bytes.buffer.asUint8List(), 'image/png');
      // });
    } catch (e) {
      print(e);
    }
  }

  Future<ByteData> getBytesFromFile(path) async {
    Uint8List bytes = File(path).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }

  // AssetImage getImage() {}
  @override
  Widget build(BuildContext context) {
    return imagePath == null
        ? Center(
            child: Text('Loading'),
          )
        : Scaffold(
            body: SafeArea(
              child: Image(
                image: FileImage(
                  File(imagePath),
                ),
                fit: BoxFit.fill,
              ),
            ),
          );
  }
}
