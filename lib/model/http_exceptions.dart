class HttpException implements Exception {
  int statusCode;

  String toString() {
    return "http_error_$statusCode";
  }
}

class HttpForbidden extends HttpException {
  final int statusCode = 403;
}

class HttpServerError extends HttpException {
  final int statusCode = 500;
}

class HttpUnauthorised extends HttpException {
  final int statusCode = 401;
}
