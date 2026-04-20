class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'A server error occurred'});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'A cache error occurred'});
}

class AuthException implements Exception {
  final String message;
  AuthException({this.message = 'An authentication error occurred'});
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'A network error occurred'});
}
