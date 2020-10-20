import 'package:flutter/material.dart';

class HamburgerMenu extends StatefulWidget {
  @override
  _HamburgerMenuState createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  final double expandedRadius = 250;
  final double shrinkedRadius = 25;
  final duration = Duration(milliseconds: 500);
  final curve = Curves.easeInOutCubic;
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        AnimatedPositioned(
          curve: curve,
          left: _expand ? -expandedRadius : 0,
          top: _expand ? -expandedRadius : 0,
          duration: duration,
          child: Stack(
            children: [
              AnimatedContainer(
                curve: curve,
                height: _expand ? 2 * expandedRadius : 2 * shrinkedRadius,
                width: _expand ? 2 * expandedRadius : 2 * shrinkedRadius,
                duration: duration,
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                left: expandedRadius + 50,
                top: expandedRadius + 50,
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: null,
                      child: Text("Logout"),
                    ),
                    RaisedButton(
                      onPressed: null,
                      child: Text("Profile"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            this.setState(() {
              this._expand = !this._expand;
            });
          },
        ),
      ],
    );
  }
}
