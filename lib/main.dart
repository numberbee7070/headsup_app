import 'package:app/auth/phone_auth.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'auth/auth.dart' as auth;
import 'auth/services/service.dart';
import 'pages/home.dart';
import 'welcome/welcome.dart' as welcome;
import 'pages/diary.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        try {
          await AuthServices.initState();
        } catch (e) {
          print(e.toString());
        }
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(error);
            return error;
          }
          return MaterialApp(
            title: 'Heads Up',
            supportedLocales: [
              Locale('en'),
            ],
            localizationsDelegates: [
              CountryLocalizations.delegate,
            ],
            theme: ThemeData(
              primarySwatch: Colors.pink,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: "home",
            // initialRoute: AuthServices.isLoggedIn ? "home" : "intro",
            routes: {
              "intro": (context) => welcome.IntroScreen(),
              "login": (context) => auth.AuthForm(),
              "home": (context) => HomePage(),
              "phone_auth": (context) => PhoneAuth(),
              "diary": (context) => Diary(),
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
      Image.asset("assets/images/splash.png"),
      SizedBox(height: 20),
      CircularProgressIndicator(),
    ],
  ),
);

Widget error = Container(
  color: Colors.white,
  child: Center(
    child: Text(
      "Error",
      textDirection: TextDirection.ltr,
    ),
  ),
);
