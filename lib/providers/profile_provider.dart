import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier {
  bool isProfileOpened = false;
  double opacity = 0;

  ProfileProvider();

  // ignore: always_declare_return_types
  openProfile() {
    isProfileOpened = true;
    notifyListeners();
  }

  // ignore: always_declare_return_types
  closeProfile() {
    isProfileOpened = false;

    notifyListeners();
  }
}
