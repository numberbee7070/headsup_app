import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data.dart' as data;
import '../model/http_backend.dart';
import '../model/serializers.dart';
import '../ui/article_card.dart';

class Reads extends StatefulWidget {
  @override
  _ReadsState createState() => _ReadsState();
}

class _ReadsState extends State<Reads> {
  Future _future;
  Size size;
  @override
  void initState() {
    super.initState();
    _future = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    return FutureBuilder<List<Article>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, idx) =>
                    ArticleContentCard(article: snapshot.data[idx]),
              ),
            );
          } else {
            return Center(
              child: Text('nothing to display'),
            );
          }
        } else {
          return shimmerCard();
        }
      },
    );
  }

  Widget shimmerCard() => Center(
          child: Stack(
        overflow: Overflow.visible,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Color(0xffe0e0e0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(data.randomQuote(),
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center),
            ),
          ),
          Positioned(
            top: -80,
            left: -40,
            width: 100,
            child: Transform.rotate(
              angle: pi / 4,
              child: Image.asset(
                "assets/images/ishi_ldpi.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ));
}
