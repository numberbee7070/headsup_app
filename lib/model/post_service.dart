import 'dart:async';

import 'package:app/auth/services/service.dart';
import 'package:chopper/chopper.dart';

part 'post_service.chopper.dart';

@ChopperApi()
abstract class PostApiService extends ChopperService {
  @Get(path: "feed/")
  Future<Response> getFeed();

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
  FutureOr<Request> onRequest(Request request) async {
    final String token = await AuthServices.accessToken;
    return request.copyWith(headers: {"Authorization": "$token"});
  }
}
