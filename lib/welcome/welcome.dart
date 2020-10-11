import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel page1 = PageViewModel(
  title: "Title of first page",
  body: "Here's first screen",
  image: Center(
    child: Image.network("https://domaine.com/image.png", height: 175.0),
  ),
);

PageViewModel page2 = PageViewModel(
  title: "Title of first page",
  body: "The next screen",
  image: const Center(child: Icon(Icons.android)),
);

PageViewModel page3 = PageViewModel(
  title: "Title of first page",
  body: "yet another screen",
  image: const Center(child: Icon(Icons.android)),
);

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: <PageViewModel>[page1, page2, page3],
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("login");
      },
      next: const Icon(Icons.navigate_next),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).accentColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
