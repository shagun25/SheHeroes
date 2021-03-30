import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ARDetectionPage extends StatefulWidget {
  static final String route = '/arDetectionPage';

  ARDetectionPage();

  @override
  _ARDetectionPageState createState() => _ARDetectionPageState();
}

class _ARDetectionPageState extends State<ARDetectionPage> {
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
    } on CameraException {
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
      if (cameras.isNotEmpty) {
        setState(() {
          // 2
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print('No camera available');
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

  @override
  Widget build(BuildContext context) {
    return controller == null || !controller.value.isInitialized
        ? const Text(
            'Loading',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          );
  }
}
