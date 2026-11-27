import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiException('network_timeout');
      case DioExceptionType.badResponse:
        final data = e.response?.data;
        final message = data is Map ? data['message']?.toString() : null;
        return ApiException(
          message ?? 'server_error',
          statusCode: e.response?.statusCode,
        );
      default:
        return ApiException('unknown_error');
    }
  }

  @override
  String toString() => message;
}
