import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';

import '../model/http_backend.dart';
import '../model/serializers.dart';

class ArticlePage extends StatefulWidget {
  static String routeName = "article";
  final int articleIdx;
  ArticlePage({@required this.articleIdx});
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  Future<Article> _future;

  final player = AudioPlayer();
  AnimationController _animation;
  bool _enablePlayback = false;
  double _iconSize = 50.0;
  StreamController<double> _iconSizeStream;

  @override
  void initState() {
    super.initState();
    _animation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    player.playerStateStream.listen(playerStateListener);
    _future = getArticle(widget.articleIdx);
    _future.then((Article value) => initialiseAudio(value.audio));
    _iconSizeStream = StreamController<double>();
  }

  @override
  void dispose() {
    player.dispose().then((_) => _animation.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollinfo) {
          if (scrollinfo.metrics.pixels < 50)
            _iconSizeStream
                .add(max(30.0, 50 - 0.5 * scrollinfo.metrics.pixels));
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: 200.0,
              flexibleSpace: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  FlexibleSpaceBar(
                    background: FutureBuilder<Article>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  snapshot.data.image,
                                  fit: BoxFit.cover,
                                ),
                                Container(color: Colors.black45),
                              ],
                            );
                          } else {
                            return Text("Error occured");
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: _enablePlayback
                        ? StreamBuilder<double>(
                            initialData: _iconSize,
                            stream: _iconSizeStream.stream,
                            builder: (context, snapshot) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    iconSize: snapshot.data,
                                    icon: Icon(
                                      Icons.replay_10,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      var newpos = player.position +
                                          Duration(seconds: -10);
                                      player.seek(newpos.isNegative
                                          ? Duration.zero
                                          : newpos);
                                    }),
                                IconButton(
                                    iconSize: snapshot.data,
                                    icon: AnimatedIcon(
                                      icon: AnimatedIcons.play_pause,
                                      progress: _animation,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (player.playing) {
                                        player.pause();
                                        _animation.reverse();
                                      } else {
                                        player.play();
                                        _animation.forward();
                                      }
                                    }),
                                IconButton(
                                  iconSize: snapshot.data,
                                  icon: Icon(
                                    Icons.forward_10,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    var newpos =
                                        player.position + Duration(seconds: 10);
                                    player.seek(newpos > player.duration
                                        ? player.duration
                                        : newpos);
                                  },
                                )
                              ],
                            ),
                          )
                        : CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                  ),
                  Positioned(
                    right: 10.0,
                    bottom: 10.0,
                    child: StreamBuilder<Duration>(
                      stream: player.positionStream,
                      builder: (context, snapshot) {
                        var position = snapshot.data ?? Duration.zero;
                        return Text(
                            "${position.toString().split('.')[0]} | ${player.duration.toString().split('.')[0]}");
                      },
                    ),
                  )
                ],
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
                      return Container();
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
                          child: shimmerWidget,
                          baseColor: Colors.grey,
                          highlightColor: Colors.white60);
                    }
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future<Article> getArticle(int idx) async {
    // await Future.delayed(Duration(minutes: 5));
    return await fetchArticle(idx);
  }

  Future initialiseAudio(String url) async {
    await player.setUrl(url);
  }

  void playerStateListener(PlayerState state) {
    switch (state.processingState) {
      case ProcessingState.loading:
        if (state.playing) {
          player.pause();
          _animation.reverse();
        }
        _enablePlayback = false;
        break;
      case ProcessingState.buffering:
        _enablePlayback = false;
        break;
      case ProcessingState.ready:
        _enablePlayback = true;
        break;
      case ProcessingState.completed:
        _animation.reverse();
        player.stop();
        break;
      case ProcessingState.none:
        _enablePlayback = false;
        _animation.reverse();
        return;
    }
    print(state.processingState);
    this.setState(() {});
  }

  Widget shimmerWidget = Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Card(
          child: SizedBox(
            height: 20.0,
            width: 250.0,
          ),
        ),
        SizedBox(height: 20.0),
        Card(
          child: SizedBox(
            height: 15.0,
            width: 250.0,
          ),
        ),
        SizedBox(height: 20.0),
        Card(
          child: SizedBox(
            height: 15.0,
            width: 250.0,
          ),
        ),
      ],
    ),
  );
}
