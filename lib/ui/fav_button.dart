import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../auth/services/service.dart';
import '../model/http_backend.dart';
import '../model/serializers.dart';

class SmileFavButton extends StatefulWidget {
  final Article article;

  SmileFavButton({Key key, @required this.article}) : super(key: key);

  @override
  SmileFavButtonState createState() => SmileFavButtonState();
}

class SmileFavButtonState extends State<SmileFavButton> {
  bool _favourite;

  @override
  void initState() {
    super.initState();
    loadState();
  }

  /// refresh the widget state
  void loadState() {
    this.setState(() {
      _favourite = AuthServices.userProfile.favouriteArticles
          .contains(widget.article.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(56.0, 56.0)),
      child: IconButton(
        color: _favourite ? Theme.of(context).accentColor : Colors.black,
        icon: Icon(Icons.emoji_emotions_outlined),
        onPressed: () async {
          this.setState(() {
            _favourite = !_favourite;
          });
          try {
            if (_favourite) {
              await addArticleFavourite(widget.article.id);
              AuthServices.userProfile.favouriteArticles.add(widget.article.id);
            } else {
              await removeArticleFavourite(widget.article.id);
              AuthServices.userProfile.favouriteArticles
                  .remove(widget.article.id);
            }
          } catch (e) {
            print(e);
            this.setState(() {
              _favourite = !_favourite;
            });
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("can not perform operation.")));
          }
        },
      ),
    );
  }
}
