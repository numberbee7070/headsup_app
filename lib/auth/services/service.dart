import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logging/logging.dart';

import '../../model/post_service.dart';
import 'profile.dart';

abstract class AuthServices {
  static FirebaseAuth _auth;

  static UserProfile userProfile = UserProfile();

  static bool get isLoggedIn => _auth.currentUser != null;

  static bool get isVerified => _auth.currentUser?.emailVerified ?? false;

  static Future<String> get accessToken => _auth.currentUser.getIdToken();

  static Future<void> initState() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    Logger.root.log(Level.CONFIG, "login status: $isLoggedIn");
    // print("verfied: $isVerified");
    if (isLoggedIn) {
      await _auth.currentUser.reload();
      userProfile.username = _auth.currentUser.displayName;
    }
  }

  static Future emailSignIn(String email, String password) async {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    // if (!user.emailVerified) {
    //   throw FirebaseAuthException(
    //       code: "email-not-verified", message: "not verified");
    // }
    userProfile.username = user.displayName;
  }

  static Future emailSignUp(
    String email,
    String username,
    String password,
  ) async {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    // await user.sendEmailVerification();
    user.updateProfile(displayName: username);
    // newSignUp();
  }

  static logout() async {
    await _auth.signOut();
  }

  static newSignUp() async {
    HttpClient client = HttpClient();
    String idtoken = await _auth.currentUser.getIdToken();
    HttpClientResponse res;
    try {
      res = await client
          .postUrl(Uri.parse("https://kyukey.tech/headsup/api/newuser/"))
          .then((HttpClientRequest req) {
        req.write(
          <String, String>{"idtoken": idtoken},
        );
        return req.close();
      });
    } on SocketException catch (_) {
      print("connection error");
      rethrow;
    }
    if (res.statusCode >= 400) {
      print("Http error ${res.statusCode}: ${res.toString()}");
      throw HttpException();
    }
  }
}
