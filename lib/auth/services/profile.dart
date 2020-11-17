import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  String name;
  String username;
  Set<int> favouriteArticles;
  String _avatar;

  String get avatar {
    return _avatar;
  }

  set avatar(String newAvatar) {
    Future<SharedPreferences> fut = SharedPreferences.getInstance();
    fut.then((prefs) {
      prefs.setString("avatar", newAvatar);
      _avatar = newAvatar;
    });
  }

  Future loadUserInfo() async {
    var instance = await SharedPreferences.getInstance();
    _avatar = instance.getString("avatar");
  }
}
