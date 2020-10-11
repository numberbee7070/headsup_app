import 'dart:async';

import 'package:chopper/chopper.dart';
import '../constants.dart';

part 'post_service.chopper.dart';

@ChopperApi()
abstract class LoginService extends ChopperService {
  @Post(path: "signup/")
  Future<Response<Map<String, dynamic>>> newSignUp(
      @Body() Map<String, String> data);

  @Post(path: "api/token/")
  Future<Response<Map<String, dynamic>>> fetchToken(
      @Body() Map<String, String> data);

  @Post(path: "api/token/refresh")
  Future<Response<Map<String, dynamic>>> refreshToken(
      @Body() Map<String, String> data);

  static LoginService create() {
    final client = ChopperClient(
      baseUrl: "https://kyukey.tech/headsup",
      services: [
        _$LoginService(),
      ],
      interceptors: [
        HttpLoggingInterceptor(),
        HttpErrorInterceptor(),
      ],
      converter: JsonConverter(),
    );
    return _$LoginService(client);
  }
}

@ChopperApi()
abstract class PostApiService extends ChopperService {
  @Post(path: "hello/")
  Future<Response> checkAccess();

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: "https://kyukey.tech/headsup",
      services: [
        _$PostApiService(),
      ],
      interceptors: [
        HttpLoggingInterceptor(),
        HttpErrorInterceptor(),
        AuthHeaderInterceptor(),
      ],
      converter: JsonConverter(),
    );
    return _$PostApiService(client);
  }
}

class HttpErrorInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode >= 400) {
      print(response.statusCode);
      throw HttpException();
    }
    return response;
  }
}

class HttpException implements Exception {
  String toString() => "Http error occurred";
}

class AuthHeaderInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    final String token = Constants.accessToken;
    return request.copyWith(headers: {"Authorization": "Bearer $token"});
  }
}
