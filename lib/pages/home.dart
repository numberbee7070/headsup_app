import 'dart:ui';

import 'package:flutter/material.dart';

import '../ui/bottom_bar.dart';
import '../ui/hamburger_menu.dart';
import '../ui/shimmer_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size size;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            OverflowBox(
              minHeight: 0.0,
              minWidth: 0.0,
              maxHeight: double.infinity,
              child: Image.asset("assets/images/home_bg.png"),
            ),
            FutureBuilder(
              future: Future.delayed(
                  Duration(seconds: 2),
                  () => [
                        {
                          "title": "Attention",
                          "image": "assets/images/attention.png"
                        },
                        {
                          "title": "Attention",
                          "image": "assets/images/attention.png",
                        }
                      ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    print(snapshot.data[0]["title"]);
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, idx) => contentCard(
                          title: snapshot.data[idx]["title"],
                          image: snapshot.data[idx]["image"],
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          indent: 10.0,
                          endIndent: 10.0,
                          height: 20.0,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('nothing to display'),
                    );
                  }
                } else {
                  return ShimmerScreen(
                    child: shimmerCard(),
                  );
                }
              },
            ),
            HamburgerMenu(),
          ],
        ),
        bottomNavigationBar: bottomNavBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FABMenuButton(),
      ),
    );
  }

  Widget contentCard({@required String title, @required String image}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              child: Text(
                title,
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image),
            ),
          ],
        ),
      );

  Widget shimmerCard() => Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Card(
              child: SizedBox(
                height: 150,
                width: size.width,
              ),
            ),
            Card(
              child: SizedBox(
                height: 150,
                width: size.width,
              ),
            ),
            Card(
              child: SizedBox(
                height: 150,
                width: size.width,
              ),
            ),
          ],
        ),
      );
}
