import 'package:app/ui/fav_button.dart';
import 'package:flutter/material.dart';

import '../model/serializers.dart';
import '../pages/article.dart';

class ArticleContentCard extends StatefulWidget {
  final Article article;

  ArticleContentCard({Key key, @required this.article}) : super(key: key);

  @override
  _ArticleContentCardState createState() => _ArticleContentCardState();
}

class _ArticleContentCardState extends State<ArticleContentCard> {
  final GlobalKey<SmileFavButtonState> _favButtonKey = GlobalKey();
  bool _visible = false;
  Image _image;

  @override
  void initState() {
    super.initState();
    _image = Image.network(widget.article.image);
    _image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
      (_, __) {
        if (this.mounted) {
          setState(() => this._visible = true);
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: AbsorbPointer(
        absorbing: !_visible,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    ArticlePage(articleIdx: widget.article.id),
              ),
            ).then((_) => _favButtonKey.currentState.loadState());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        widget.article.image,
                        colorBlendMode: BlendMode.darken,
                        color: Colors.black38,
                      ),
                      Icon(
                        Icons.play_circle_outline_rounded,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SmileFavButton(
                          key: _favButtonKey, article: widget.article),
                      Expanded(
                        child: Text(
                          widget.article.title,
                          style: TextStyle(fontSize: 20.0),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
