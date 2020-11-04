import 'package:app/auth/set_profile.dart';
import 'package:flutter/material.dart';

import '../auth/services/service.dart';
import '../model/exceptions.dart';
import '../ui/hamburger_menu.dart';
import 'diary.dart';
import 'reads.dart';

class HomePage extends StatefulWidget {
  static String routeName = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = loadUser();
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
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              extendBody: true,
              body: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    snapshot.hasError
                        ? errorWidget()
                        : TabBarView(
                            children: [
                              Reads(),
                              Diary(),
                            ],
                          ),
                    HamburgerMenu(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: TabBar(
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.red,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.book,
                        // color: Colors.red,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.bookmark,
                        // color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.gamepad_rounded),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
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
}
