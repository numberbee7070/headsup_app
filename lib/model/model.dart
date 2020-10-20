import 'package:shared_preferences/shared_preferences.dart';
import 'post_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/services/service.dart';

class Model {
  static PostApiService _postApiService;

  static void create() {
    _postApiService = PostApiService.create();
  }

  static void dispose() {
    _postApiService.dispose();
  }
}
