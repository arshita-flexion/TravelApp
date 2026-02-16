// Handle Errors
import 'package:dio/dio.dart';

String handleError(dynamic error) {
  if (error is DioException) {
    return error.response?.data['message'] ?? error.message ?? '';
  }
  return error.toString();
}
