import 'package:app/auth/services/service.dart';
import 'package:app/ui/hamburger_menu.dart';
import 'package:flutter/material.dart';
import '../auth/services/service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Center(
                child: Text("This is the home page"),
              ),
            ),
            HamburgerMenu(),
          ],
        ),
      ),
    );
  }
}
