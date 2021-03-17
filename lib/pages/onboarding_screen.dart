import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:safety/pages/login_page.dart';

class OnboardingScreen extends StatelessWidget {
  final List<PageViewModel> listPageViewModels = [
    PageViewModel(
      title: 'Introduction Page',
      body: 'First Page',
      image: Image.asset('assets/SheHeroes.png'),
    ),
    PageViewModel(
      title: 'Introduction Page',
      body: 'Second Page',
      image: Image.asset('assets/SheHeroes.png'),
    ),
    PageViewModel(
      title: 'Introduction Page',
      body: 'Third Page',
      image: Image.asset('assets/SheHeroes.png'),
    ),
    PageViewModel(
      title: 'Introduction Page',
      body: 'Fourth Page',
      image: Image.asset('assets/SheHeroes.png'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: listPageViewModels,
        done: const Text(
          "Continue",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
