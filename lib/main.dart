import 'package:flutter/material.dart';
import 'welcome/welcome.dart' as welcome;
import 'auth/login.dart' as auth;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: welcome.IntroScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "login": (context) => auth.Login(),
      },
    );
  }
}
