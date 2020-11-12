import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../auth/services/service.dart';
import '../auth/set_profile.dart';
import '../game/game.dart';
import '../model/exceptions.dart';
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

  List<String> titles = ['Reads', 'Diary'];

  @override
  void initState() {
    _tabEventStream = StreamController<int>.broadcast();
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
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
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
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
                      return Text(titles[snapshot.data]);
                    else
                      return Text(titles[0]);
                  }),
            ),
            drawer: _drawer(),
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
                  builder: (BuildContext context) => BubbleGame(
                    title: "Bubble game",
                  ),
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
    print("fetching user details");
    try {
      await AuthServices.fetchUserDetails();
    } on HttpForbidden {
      print("user does not exist. create profile");
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => SetProfile()));
    }
  }

  Widget errorWidget() => Container(
        child: Center(
          child: Column(
            children: [
              Text("Error connecting"),
              FlatButton(
                onPressed: () => this.setState(() => this._future = loadUser()),
                child: Text("Tap to try again"),
              ),
            ],
          ),
        ),
      );

  Widget _drawer() => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Card(
                    elevation: 2.0,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/images/ishi_ldpi.png",
                        height: 80.0,
                        width: 80.0,
                      ),
                    ),
                  ),
                  Text(AuthServices.userProfile.username),
                ],
              ),
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                AuthServices.logout();
                Navigator.pushReplacementNamed(context, AuthForm.routeName);
              },
            ),
          ],
        ),
      );
}
