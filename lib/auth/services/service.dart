import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../model/exceptions.dart';
import '../../model/http_backend.dart';
import 'profile.dart';

abstract class AuthServices {
  static FirebaseAuth _auth;

  static UserProfile userProfile = UserProfile();

  static bool get isLoggedIn => _auth.currentUser != null;

  /// check whether user email is verified or not
  /// always return true for OAuth and phone sign in
  /// returns false if user is not logged in
  static Future<bool> get isVerified async {
    if (_auth.currentUser?.email != null) {
      await _auth.currentUser.reload();
      return _auth.currentUser.emailVerified;
    }
    return true && isLoggedIn;
  }

  static Future<String> get accessToken => _auth.currentUser?.getIdToken();

  static Future<void> initState() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    Logger.root.log(Level.CONFIG,
        "login status: $isLoggedIn email: ${_auth.currentUser?.email}");
    // print("verfied: $isVerified");
    if (isLoggedIn) {
      await _auth.currentUser.reload();
      userProfile.username = _auth.currentUser.displayName;
      userProfile.loadUserInfo();
    }
  }

  static Future emailSignIn(String email, String password) async {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (!user.emailVerified) {
      throw EmailNotVerified();
    }
  }

  static Future emailSignUp(
    String email,
    String password,
  ) async {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    await user.sendEmailVerification();
  }

  static logout() async {
    await _auth.signOut();
  }

  static Future<Map<String, String>> get authHeader async {
    final token = await accessToken;
    return {"Authorization": "Token $token"};
  }

  static newSignUp(String username) async {
    final uri = Uri.parse(BASE_URI + "user/create/");
    final token = await accessToken;
    http.Response res;
    try {
      res = await http.post(uri,
          body: json.encode({"idtoken": token, "username": username}),
          headers: {"Content-Type": "application/json"});
      print(res.body);
    } on SocketException catch (_) {
      print("connection error");
      rethrow;
    }
    if (res.statusCode >= 400) {
      print("Http error ${res.statusCode}: ${res.toString()}");
      throw Exception("http error");
    }
  }

  static Future fetchUserDetails() async {
    final uri = Uri.parse(BASE_URI + "user/");
    final headers = await authHeader;
    http.Response res;

    try {
      res = await http.get(
        uri,
        headers: headers,
      );
    } on SocketException {
      rethrow;
    }
    // if user does not exists
    if (res.statusCode == 403) {
      throw HttpForbidden();
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    userProfile.username = data["username"];
    userProfile.favouriteArticles = Set<int>.from(data["favourites"]);
    return data;
  }

  static Future changeUsername(String newUsername) async {
    final uri = Uri.parse(BASE_URI + 'user/');
    final headers = await authHeader;
    await http.patch(uri, headers: headers, body: {"username": newUsername});
    userProfile.username = newUsername;
  }
}
