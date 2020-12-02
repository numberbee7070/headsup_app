import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

import 'word_list.dart';

class BubbleGame extends StatefulWidget {
  @override
  _BubbleGameState createState() => _BubbleGameState();
}

class _BubbleGameState extends State<BubbleGame> {
  final random = new Random();
  bool k = true;
  bool click = true;
  bool t = false;
  bool p = false;
  double l = 100;
  double w = 100;
  int tt = 0;
  int score = 0;
  int a = 0;
  int b = 0;
  bool k1 = true;
  bool click1 = true;
  bool t1 = false;
  bool p1 = false;
  double l1 = 400;
  double w1 = 200;
  int tt11 = 0;
  int score1 = 0;
  int a1 = 0;
  int b1 = 0;
  final _player = AudioPlayer();

  bool _splashVisible = true;

  @override
  void initState() {
    super.initState();
    _player.setAsset("assets/audio/bubbleburst.mp3");
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    Future.delayed(
        Duration(seconds: 2),
        () => this.setState(() {
              _splashVisible = false;
            }));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    a = ((MediaQuery.of(context).size.height.round() - 200) / 100).round();
    b = ((MediaQuery.of(context).size.width.round() - 200) / 100).round();
    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      crossFadeState:
          _splashVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/game_splash.jpg',
          fit: BoxFit.cover,
        ),
      ),
      secondChild: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.pink[500],
          body: SafeArea(
            child: Stack(children: <Widget>[
              Positioned(
                top: 0.0,
                child: SizedBox(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                    "Score: ${score.toString()}",
                    textScaleFactor: 1.5,
                  )),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: Positioned(
                  top: l,
                  left: w,
                  child: Column(
                    children: [
                      click
                          ? GestureDetector(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: tt),
                                height: t ? 100 : 0,
                                child: Image.asset(
                                  'assets/images/lines.png',
                                  scale: 0.5,
                                ),
                                onEnd: () {
                                  if (t == true) {
                                    setState(() {
                                      tt = 0;
                                      int aa = random.nextInt(a);
                                      int bb = random.nextInt(b + 1);
                                      if (aa % 2 == 1) aa--;
                                      l = (100 * (aa + 1)).toDouble();
                                      w = (100 * bb).toDouble();
                                      k = true;
                                      t = false;
                                    });
                                  }
                                },
                              ),
                            )
                          : Padding(padding: EdgeInsets.all(0)),
                      k
                          ? GestureDetector(
                              child: Container(
                                child: Container(
                                    height: 95,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    'assets/images/bubble.png')
                                                .image)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          getPositiveWord(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                              ),
                              onTap: () {
                                _player.play().then((_) => _player.stop());
                                score = score + 1;
                                setState(() {
                                  tt = 250;
                                  k = false;
                                  t = true;
                                  tt11 = 0;
                                  int aa = random.nextInt(a);
                                  int bb = random.nextInt(b + 1);
                                  if (aa % 2 == 0) aa++;
                                  l1 = (100 * (aa + 1)).toDouble();
                                  w1 = (100 * bb).toDouble();
                                  k1 = true;
                                  t1 = false;
                                });
                              },
                            )
                          : Padding(padding: EdgeInsets.all(0)),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: Positioned(
                  top: l1,
                  left: w1,
                  child: Column(
                    children: [
                      click1
                          ? GestureDetector(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: tt11),
                                height: t1 ? 100 : 0,
                                child: Image.asset(
                                  'assets/images/lines.png',
                                  scale: 0.5,
                                ),
                                onEnd: () {
                                  if (t1 == true) {
                                    setState(() {
                                      tt11 = 0;
                                      int aa = random.nextInt(a);
                                      int bb = random.nextInt(b + 1);
                                      if (aa % 2 == 0) aa++;
                                      l1 = (100 * (aa + 1)).toDouble();
                                      w1 = (100 * bb).toDouble();
                                      k1 = true;
                                      t1 = false;
                                    });
                                  }
                                },
                              ),
                            )
                          : Padding(padding: EdgeInsets.all(0)),
                      k1
                          ? GestureDetector(
                              child: Container(
                                child: Container(
                                    height: 95,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    'assets/images/bubble.png')
                                                .image)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          getNegativeWord(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                              ),
                              onTap: () {
                                _player.play().then((_) => _player.stop());
                                score = score - 1;
                                setState(() {
                                  tt11 = 250;
                                  k1 = false;
                                  t1 = true;
                                  tt = 0;
                                  int aa = random.nextInt(a);
                                  int bb = random.nextInt(b + 1);
                                  if (aa % 2 == 1) aa--;
                                  l = (100 * (aa + 1)).toDouble();
                                  w = (100 * bb).toDouble();
                                  k = true;
                                  t = false;
                                });
                              },
                            )
                          : Padding(padding: EdgeInsets.all(0)),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
