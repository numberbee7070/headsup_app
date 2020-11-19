import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'word_list.dart';

class BubbleGame extends StatefulWidget {
  BubbleGame({Key key, this.title}) : super(key: key);

  final String title;

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

  @override
  void initState() {
    super.initState();
    _player.setAsset("assets/audio/bubbleburst.mp3");
  }

  @override
  Widget build(BuildContext context) {
    a = ((MediaQuery.of(context).size.height.round() - 200) / 100).round();
    b = ((MediaQuery.of(context).size.width.round() - 200) / 100).round();
    print(a);
    print(b);
    return Scaffold(
        body: Center(
            child: Stack(children: <Widget>[
      Container(
        color: Colors.pink[500],
      ),
      Positioned(top: 50, left: 20, child: Text("Score")),
      Positioned(top: 70, left: 20, child: Text(score.toString())),
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
                                  print(l);
                                  print(w);
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
                                  child: Text(getPositiveWord()),
                                )),
                          ),
                          onTap: () {
                            _player.play().then((_) => _player.stop());
                            score = score + 1;
                            setState(() {
                              tt = 250;
                              k = false;
                              t = true;
                              print("vsjvnsjk");
                              tt11 = 0;
                              int aa = random.nextInt(a);
                              int bb = random.nextInt(b + 1);
                              if (aa % 2 == 0) aa++;
                              l1 = (100 * (aa + 1)).toDouble();
                              w1 = (100 * bb).toDouble();
                              k1 = true;
                              t1 = false;
                              print(l);
                              print(w);
                            });
                          },
                        )
                      : Padding(padding: EdgeInsets.all(0)),
                ],
              ))),
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
                                  print(l);
                                  print(w);
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
                                  child: Text(getNegativeWord()),
                                )),
                          ),
                          onTap: () {
                            _player.play().then((_) => _player.stop());
                            score = score - 1;
                            setState(() {
                              tt11 = 250;
                              k1 = false;
                              t1 = true;
                              print("vsjvnsjk");
                              tt = 0;
                              int aa = random.nextInt(a);
                              int bb = random.nextInt(b + 1);
                              if (aa % 2 == 1) aa--;
                              l = (100 * (aa + 1)).toDouble();
                              w = (100 * bb).toDouble();
                              k = true;
                              t = false;
                              print(l);
                              print(w);
                            });
                          },
                        )
                      : Padding(padding: EdgeInsets.all(0)),
                ],
              )))
    ])));
  }
}
