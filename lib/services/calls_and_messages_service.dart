import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CallsAndMessagesService {
  void call(String number) => launch('tel://$number');

  void sendSms(String number) => launch('sms:$number');

  void sendEmail(String email) => launch('mailto:$email');

  void takePhoto() async {
    print('Take Image');
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.camera)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        GallerySaver.saveImage(
          recordedImage.path,
        ).then((bool success) {
          print('Capture Status is: $success');
        });
      }
    });
  }

}
