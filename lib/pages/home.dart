import 'dart:ui';

import 'package:app/model/http_backend.dart';
import 'package:app/model/serializers.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../ui/bottom_bar.dart';
import '../ui/hamburger_menu.dart';
import '../data.dart' as data;

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
            FutureBuilder<List<Article>>(
              future: fetchArticles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, idx) => contentCard(
                          title: snapshot.data[idx].body["title"],
                          // image: snapshot.data[idx]["image"],
                          image: null,
                          chapter: snapshot.data[idx].chapter.toInt(),
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
                  return Shimmer.fromColors(
                    baseColor: Colors.pink[300],
                    highlightColor: Colors.pink[400],
                    child: shimmerCard(),
                  );
                }
              },
            ),
            HamburgerMenu(),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FABMenuButton(),
      ),
    );
  }

  Widget contentCard(
          {@required String title,
          @required String image,
          @required int chapter}) =>
      GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, "article", arguments: chapter),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(), // replace with network image
                ),
              ],
            ),
          ),
        ),
      );

  Widget shimmerCard() => Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Wrap(
          children: [
            Card(
              child: SizedBox(
                height: 200,
                width: size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                data.randomQuote(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: SizedBox(
                height: 200,
                width: size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                data.randomQuote(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: SizedBox(
                height: 200,
                width: size.width,
              ),
            ),
          ],
        ),
      );
}
