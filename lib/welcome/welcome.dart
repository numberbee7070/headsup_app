import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../auth/auth.dart';

class IntroScreen extends StatelessWidget {
  static String routeName = "intro";
  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      imageFlex: 3,
      imagePadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
    );

    PageViewModel page1 = PageViewModel(
      title: "PLAY & RELAX",
      image: Image.asset("assets/images/welcome_page1.png"),
      body: "Lorem ipsum dolor sit amet",
      decoration: pageDecoration,
    );

    PageViewModel page2 = PageViewModel(
      title: "CONNECT WITH MATES",
      image: Image.asset("assets/images/welcome_page2.png"),
      body: "Lorem ipsum dolor sit amet",
      decoration: pageDecoration,
    );

    PageViewModel page3 = PageViewModel(
      title: "TRUSTED EXPERTS",
      image: Image.asset("assets/images/welcome_page3.png"),
      body: "Lorem ipsum dolor sit amet",
      decoration: pageDecoration,
    );

    return IntroductionScreen(
      pages: <PageViewModel>[page1, page2, page3],
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        Navigator.pushReplacementNamed(context, AuthForm.routeName);
      },
      next: const Icon(Icons.navigate_next),
      showSkipButton: true,
      skip: const Text("Skip"),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Theme.of(context).accentColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
