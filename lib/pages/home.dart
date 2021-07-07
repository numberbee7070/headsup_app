import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/services/service.dart';
import '../auth/set_profile.dart';
import '../game/game.dart';
import '../model/exceptions.dart';
import '../ui/drawer.dart';
import 'diary.dart';
import 'reads.dart';

class HomePage extends StatefulWidget {
  static String routeName = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future _future;
  StreamController<int> _tabEventStream;

  List<String> _titles = const ['Reads', 'Diary'];

  @override
  void initState() {
    super.initState();

    _tabEventStream = StreamController<int>.broadcast();
    _tabController = TabController(length: 2, vsync: this);

    _future = loadUser();
    _tabController.addListener(() => _tabEventStream.add(_tabController.index));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color: Theme.of(context).primaryColor);
          }
          if (snapshot.hasError) {
            print("homepage: ${snapshot.error}");
          }
          return Scaffold(
            appBar: AppBar(
              title: StreamBuilder<int>(
                  initialData: 0,
                  stream: _tabEventStream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Text(_titles[snapshot.data]);
                    else
                      return Text(_titles[0]);
                  }),
            ),
            drawer: AppDrawer(),
            extendBody: true,
            body: snapshot.hasError
                ? errorWidget()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      Reads(),
                      Diary(),
                    ],
                  ),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: StreamBuilder<int>(
                initialData: 0,
                stream: _tabEventStream.stream,
                builder: (context, snapshot) => TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  tabs: [
                    Tab(
                      icon: Icon(
                        snapshot.data == 0 ? Icons.book : Icons.book_outlined,
                        // color: Colors.red,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        snapshot.data == 1
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        // color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BubbleGame(),
                ),
              ),
              child: Icon(Icons.gamepad_rounded),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        });
  }

  Future loadUser() async {
    /// if user does not exist on backend
    /// ask user to create profile
    try {
      await AuthServices.fetchUserDetails();
    } on HttpForbidden {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => SetProfile()));
      await AuthServices.fetchUserDetails();
    }
  }

  Widget errorWidget() => Container(
        child: Center(
          child: Column(
            children: [
              Text("Error connecting"),
              TextButton(
                onPressed: () => this.setState(() => this._future = loadUser()),
                child: Text("Tap to try again"),
              ),
            ],
          ),
        ),
      );
}
