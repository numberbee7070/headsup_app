import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/http_backend.dart';
import '../model/serializers.dart';

class ArticlePage extends StatefulWidget {
  static String routeName = "article";
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Future _future;

  @override
  Widget build(BuildContext context) {
    final int idx = ModalRoute.of(context).settings.arguments;
    _future = getArticle(idx);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 200.0,
            flexibleSpace: FutureBuilder<Article>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    // return Image.network(snapshot.data.imageurl);
                    return Container(color: Colors.indigo);
                  } else {
                    return Text("Error occured");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              FutureBuilder<Article>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          snapshot.data.title,
                          style: TextStyle(fontSize: 30.0),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Text("Error occured");
                    }
                  } else {
                    return Shimmer.fromColors(
                        child: SizedBox(
                          height: 10,
                          width: 100,
                        ),
                        baseColor: Colors.grey,
                        highlightColor: Colors.indigo);
                  }
                },
              ),
              FutureBuilder<Article>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            snapshot.data.body,
                            style: TextStyle(
                              letterSpacing: 1.2,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      );
                    } else {
                      return Text("Error occured");
                    }
                  } else {
                    return Shimmer.fromColors(
                        child: SizedBox(
                          height: 30,
                          width: 100,
                        ),
                        baseColor: Colors.grey,
                        highlightColor: Colors.black);
                  }
                },
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future<Article> getArticle(int idx) async {
    return await fetchArticle(idx);
  }
}
