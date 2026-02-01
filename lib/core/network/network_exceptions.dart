class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException({required this.message, this.statusCode});

  @override
  String toString() => 'NetworkException: $message (Status: $statusCode)';
}

class ConnectionTimeoutException extends NetworkException {
  ConnectionTimeoutException()
    : super(message: 'Connection timeout', statusCode: null);
}

class BadResponseException extends NetworkException {
  BadResponseException({required super.message, super.statusCode});
}

class RequestCancelledException extends NetworkException {
  RequestCancelledException()
    : super(message: 'Request cancelled', statusCode: null);
}

class NoInternetConnectionException extends NetworkException {
  NoInternetConnectionException()
    : super(message: 'No internet connection', statusCode: null);
}

class BadCertificateException extends NetworkException {
  BadCertificateException()
    : super(message: 'Bad certificate', statusCode: null);
}

class UnknownNetworkException extends NetworkException {
  UnknownNetworkException({String? message})
    : super(message: message ?? 'Unknown error occurred', statusCode: null);
}
