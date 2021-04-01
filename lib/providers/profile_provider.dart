import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier {
  bool isProfileOpened = false;
  double opacity = 0;

  ProfileProvider();

  openProfile() {
    isProfileOpened = true;
    notifyListeners();
  }

  closeProfile() {
    isProfileOpened = false;

    notifyListeners();
  }
}
