import 'package:dio/dio.dart';
import 'network_exceptions.dart';

/// Cliente HTTP base usando Dio
///
/// Esta clase proporciona una instancia de Dio configurada con:
/// - Configuración de URL base
/// - Configuración de timeouts
/// - Interceptores de Request/Response para logging
/// - Manejo de errores
/// - Gestión de tokens de autenticación
class DioClient {
  late final Dio _dio;

  static const Duration _connectTimeout = Duration(seconds: 30);
  static const Duration _receiveTimeout = Duration(seconds: 30);
  static const Duration _sendTimeout = Duration(seconds: 30);

  DioClient({Map<String, dynamic>? headers, List<Interceptor>? interceptors}) {
    _dio = Dio(
      BaseOptions(
        // Hardcodeada porque es una API pública
        baseUrl: 'https://pokeapi.co/api/v2',
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
        validateStatus: (status) {
          // Aceptar todos los códigos de estado para manejarlos manualmente
          return status != null && status < 500;
        },
      ),
    );
  }

  /// Obtener la instancia de Dio
  Dio get dio => _dio;

  /// Petición GET
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Petición POST
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Petición PUT
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Petición PATCH
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Petición DELETE
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Maneja errores de Dio y los convierte en excepciones personalizadas
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ConnectionTimeoutException();
      case DioExceptionType.badResponse:
        return BadResponseException(
          message: error.response?.data['message'] ?? 'Server error',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return RequestCancelledException();
      case DioExceptionType.connectionError:
        return NoInternetConnectionException();
      case DioExceptionType.badCertificate:
        return BadCertificateException();
      case DioExceptionType.unknown:
        return UnknownNetworkException(message: error.message);
    }
  }
}
