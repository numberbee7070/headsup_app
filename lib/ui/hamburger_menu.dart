import 'package:flutter/material.dart';

class HamburgerMenu extends StatefulWidget {
  @override
  _HamburgerMenuState createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  final double expandedRadius = 180;
  final double shrinkedRadius = 25;
  final duration = Duration(milliseconds: 1000);
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      transform: Matrix4.identity()
        ..translate(_expanded ? -expandedRadius / 3 : 0.0,
            _expanded ? -expandedRadius / 3 : 0.0),
      child: Stack(
        children: [
          AnimatedContainer(
            height: _expanded ? 2 * expandedRadius : 2 * shrinkedRadius,
            width: _expanded ? 2 * expandedRadius : 2 * shrinkedRadius,
            duration: duration,
            decoration: BoxDecoration(
              color: Colors.green[200],
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            left: expandedRadius / 1.5,
            top: expandedRadius / 2,
            child: Column(
              children: [
                RaisedButton(
                  onPressed: null,
                  child: Text("Home"),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text("Mood"),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text("Read"),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text("Therapy"),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text("Settings"),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            top: _expanded ? expandedRadius / 3 : 0,
            left: _expanded ? expandedRadius / 3 : 0,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                this.setState(() {
                  this._expanded = !this._expanded;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
