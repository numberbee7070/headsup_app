import 'package:app/model/serializers.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../model/http_backend.dart';

class ArticlePage extends StatefulWidget {
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
                      return Text(snapshot.data.body["title"]);
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
                      return Text(snapshot.data.body["text"]);
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
