import 'package:flutter/material.dart';

import '../ui/bottom_bar.dart';
import '../ui/hamburger_menu.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(width: 50),
        backgroundColor: Colors.white,
        title: Text("Diary"),
      ),
      body: Stack(
        children: [
          Container(),
          HamburgerMenu(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
