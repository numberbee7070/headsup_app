import 'package:app/pages/home.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'welcome/welcome.dart' as welcome;
import 'auth/auth.dart' as auth;
import 'package:app/auth/oauth.dart' as oauth;
import 'model/model.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) => print("${event.message}"));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Model.create(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return error;
          }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: Constants.isLoggedIn ? "home" : "intro",
            routes: {
              "intro": (context) => welcome.IntroScreen(),
              "login": (context) => auth.AuthForm(),
              "oauth": (context) => oauth.OauthForm(),
              "home": (context) => HomePage(),
            },
          );
        } else {
          return splash;
        }
      },
    );
  }
}

Widget splash = Container(
  color: Colors.white,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/welcome.png"),
      CircularProgressIndicator(),
    ],
  ),
);

Widget error = Container(
  color: Colors.white,
  child: Center(
    child: Text("Error"),
  ),
);
