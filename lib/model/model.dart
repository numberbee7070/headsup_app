import 'package:shared_preferences/shared_preferences.dart';
import 'post_service.dart';
import 'package:chopper/chopper.dart';
import 'package:app/constants.dart';

class Model {
  static LoginService _loginService;
  static PostApiService _postApiService;

  static Future<void> create() async {
    _loginService = LoginService.create();
    _postApiService = PostApiService.create();
    SharedPreferences pref = await SharedPreferences.getInstance();
    Constants.refreshToken = pref.getString("server_refresh");
    Constants.isLoggedIn = Constants.refreshToken != null;
  }

  static void dispose() {
    _loginService.dispose();
    _postApiService.dispose();
  }

  static Future<void> newLogin(
    String username,
    String password,
  ) async {
    Response<Map<String, dynamic>> res = await _loginService.fetchToken({
      "username": username,
      "password": password,
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("server_refresh", res.body["refresh"]);
    Constants.accessToken = res.body["access"];
  }

  static Future<void> signUp(
    String username,
    String password,
    String email,
  ) async {
    await _loginService.newSignUp({
      "username": username,
      "password": password,
      "email": email,
    });
    await newLogin(username, password);
  }

  static Future<void> refreshToken() async {
    Response<Map<String, dynamic>> res =
        await _loginService.refreshToken({"refresh": Constants.refreshToken});
    Constants.refreshToken = res.body["access"];
  }
}
