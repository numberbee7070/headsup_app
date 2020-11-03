import 'dart:ui';

import 'package:flutter/material.dart';

import '../ui/hamburger_menu.dart';
import 'diary.dart';
import 'reads.dart';

class HomePage extends StatefulWidget {
  static String routeName = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size size;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              TabBarView(
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
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.book),
              ),
              Tab(
                icon: Icon(Icons.bookmark),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.gamepad_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
