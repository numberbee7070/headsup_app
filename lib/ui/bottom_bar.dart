import 'package:flutter/material.dart';

Widget bottomNavBar = BottomAppBar(
  shape: CircularNotchedRectangle(),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        onPressed: null,
        icon: Icon(Icons.code),
      ),
      IconButton(
        onPressed: null,
        icon: Icon(Icons.code),
      ),
      IconButton(
        onPressed: null,
        icon: Icon(Icons.code),
      ),
      IconButton(
        onPressed: null,
        icon: Icon(Icons.code),
      ),
    ],
  ),
);

class FABMenuButton extends StatefulWidget {
  @override
  _FABMenuButtonState createState() => _FABMenuButtonState();
}

class _FABMenuButtonState extends State<FABMenuButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  bool _active = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    controller.addListener(() => this.setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animation,
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.create),
          ),
          builder: (context, child) => Transform.translate(
            offset: Offset(0.0, -120 * animation.value),
            child: child,
          ),
        ),
        AnimatedBuilder(
          animation: animation,
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.create),
          ),
          builder: (context, child) => Transform.translate(
            offset: Offset(0.0, -60 * animation.value),
            child: child,
          ),
        ),
        FloatingActionButton(
          onPressed: () => this.setState(() {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          }),
          child: Icon(Icons.create),
        ),
      ],
    );
  }
}
