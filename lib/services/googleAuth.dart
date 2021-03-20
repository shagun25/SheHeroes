import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:safety/pages/switcher.dart';

class GoogleAuthenticate {
  var googleSignIn;
  BuildContext _context;

  GoogleAuthenticate(this._context) {
    googleSignIn = GoogleSignIn();
  }

  Future loginViaGoogle() async {
    try {
      if (!await googleSignIn.isSignedIn()) {
        // Checking If Already Sign In With Google
        final user = await googleSignIn.signIn();
        if (user == null) {
          print("Google Sign In Not Completed");
        } else {
          final googleAuth = await user.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          var registeredUser =
              await FirebaseAuth.instance.signInWithCredential(credential);

          ScaffoldMessenger.of(this._context).showSnackBar(
              SnackBar(content: Text('Wait.... Process is going on')));

          print("Log In Successful " + registeredUser.user.displayName);
          Future.delayed(Duration(milliseconds: 800)).then((value) =>
              Navigator.pushNamedAndRemoveUntil(
                  this._context, Switcher.route, (route) => false));
        }
      } else {
        print("Already Signed In");
        Future.delayed(Duration(milliseconds: 800)).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                this._context, Switcher.route, (route) => false));
      }
    } catch (e) {
      messageShow(this._context, "Log In Error",
          "Log-in not Completed or\nEmail of this Account Already Present With Other Credentials");
    }
  }

  Future<bool> logOut() async {
    try {
      googleSignIn.disconnect();
      googleSignIn.signOut();
      FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}

Future<dynamic> messageShow(
    BuildContext _context, String _title, String _content) {
  return showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black38,
          title: Text(
            _title,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            _content,
            style: TextStyle(color: Colors.white),
          ),
        );
      });
}
