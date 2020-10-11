import 'dart:convert';

import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:http/http.dart' as http;

class GoogleOAuthHelper {
  static final String _clientId =
      "161508263510-ltncqohqfoqtkdak4fo8kv5ah63i0ovl.apps.googleusercontent.com";
  static final List<String> _scopes = ["email", "openid", "profile"];
  static OAuth2Client _googleClient;

  static Future<String> getAccessToken() async {
    _googleClient = GoogleOAuth2Client(
      redirectUri:
          'com.googleusercontent.apps.161508263510-ltncqohqfoqtkdak4fo8kv5ah63i0ovl:/oauth2redirect',
      customUriScheme:
          'com.googleusercontent.apps.161508263510-ltncqohqfoqtkdak4fo8kv5ah63i0ovl',
    );
    AccessTokenResponse _response =
        await _googleClient.getTokenWithAuthCodeFlow(
      clientId: _clientId,
      scopes: _scopes,
    );
    if (_response.isExpired()) {
      _response = await _googleClient.refreshToken(_response.refreshToken);
    }
    return _response.accessToken;
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    String token = await getAccessToken();
    var client = http.Client();
    var uri = Uri.https("openidconnect.googleapis.com", "/v1/userinfo",
        {"scopes": "openid profile email"});
    http.Response res =
        await client.get(uri, headers: {"Authorization": "Bearer $token"});
    return json.decode(res.body);
  }
}
