class HttpException implements Exception {
  int statusCode;

  String toString() {
    return "http_error_$statusCode";
  }
}

/// http status code 403
class HttpForbidden extends HttpException {
  final int statusCode = 403;
}

/// http status code 500
class HttpServerError extends HttpException {
  final int statusCode = 500;
}

/// http status code 401
class HttpUnauthorised extends HttpException {
  final int statusCode = 401;
}

class EmailNotVerified implements Exception {
  static final String message =
      "email not verified. please verify your email using link";
  String toString() => message;
}
