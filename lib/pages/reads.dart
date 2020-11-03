import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data.dart' as data;
import '../model/http_backend.dart';
import '../model/serializers.dart';
import 'article.dart';

class Reads extends StatefulWidget {
  @override
  _ReadsState createState() => _ReadsState();
}

class _ReadsState extends State<Reads> {
  Size size;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    return Stack(
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
                      title: snapshot.data[idx].title,
                      image: snapshot.data[idx].image,
                      id: snapshot.data[idx].id,
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
        )
      ],
    );
  }

  Widget contentCard(
          {@required String title, @required String image, @required int id}) =>
      GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, ArticlePage.routeName, arguments: id),
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
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(image), // replace with network image
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
