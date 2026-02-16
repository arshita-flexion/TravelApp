// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/app_exports.dart';
import '../endpoints/api_endpoint.dart';

enum RequestType { GET, POST, PUT, DELETE, PATCH, MULTIPART_POST, MULTIPART_PUT }

class ApiClient {
  final Dio _dio;

  ApiClient()
    : _dio = Dio(BaseOptions())
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            request: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        );

  // --------------------------- HEADERS ---------------------------

  static Map<String, String> _buildHeaders() {
    final header = <String, String>{'Content-Type': 'application/json'};
    String? deviceToken = Prefobj.preferences?.get(Prefkeys.AUTHTOKEN) ?? '';

    if (deviceToken != null && deviceToken.isNotEmpty) {
      header['Authorization'] = 'Bearer $deviceToken';
    }
    return header;
  }

  // --------------------------- REQUEST METHOD ---------------------------

  Future<Map<String, dynamic>> request(
    RequestType type,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? multipartData,
  }) async {
    try {
      // Set headers dynamically for each request
      final headers = _buildHeaders();
      
      // IMPORTANT: For multipart requests, we must NOT set the Content-Type header manually.
      // Dio will automatically set it to 'multipart/form-data' with the correct boundary
      // required by the backend to parse the fields (name, mobileNumber, etc.)
      if (type == RequestType.MULTIPART_POST || type == RequestType.MULTIPART_PUT) {
        headers.remove('Content-Type');
      }

      final Response response = switch (type) {
        RequestType.GET => await _dio.get(path, options: Options(headers: headers)),
        RequestType.POST => await _dio.post(
          path,
          data: data,
          options: Options(headers: headers),
        ),
        RequestType.PUT => await _dio.put(
          path,
          data: data,
          options: Options(headers: headers),
        ),
        RequestType.DELETE => await _dio.delete(path, options: Options(headers: headers)),
        RequestType.PATCH => await _dio.patch(
          path,
          data: data,
          options: Options(headers: headers),
        ),
        RequestType.MULTIPART_POST => await _dio.post(
          path,
          data: await _buildMultipartForm(multipartData),
          options: Options(headers: headers),
        ),
        RequestType.MULTIPART_PUT => await _dio.put(
          path,
          data: await _buildMultipartForm(multipartData),
          options: Options(headers: headers),
        ),
      };

      return _handleSuccess(response);
    } on DioException catch (error) {
      return _handleDioError(error);
    } catch (e) {
      rethrow;
    }
  }

  // --------------------------- SUCCESS HANDLERS ---------------------------

  Map<String, dynamic> _handleSuccess(Response response) {
    if ([200, 201, 204].contains(response.statusCode)) {
      return response.data;
    } else {
      throw _handleFailure(response);
    }
  }

  // --------------------------- ERROR HANDLERS ---------------------------

  DioException _handleFailure(Response response) {
    // final code = response.statusCode ?? 0;
    final responseData = response.data;
    String message = "Something went wrong";
    // Improved validation error handling to support multiple formats
    if (responseData is Map<String, dynamic>) {
      // Format 1: Direct validationErrors array
      if (responseData.containsKey('validationErrors') && responseData['validationErrors'] is List) {
        final List errors = responseData['validationErrors'];
        if (errors.isNotEmpty) {
          // Extract all error messages and join them
          message = errors.map((e) => e['message']).where((m) => m != null).join('');
          if (message.isEmpty) {
            message = "Validation error occurred";
          }
        }
      }
      // Fallback to standard message fields
      else if (responseData.containsKey('message')) {
        message = responseData['message'];
      } else if (responseData.containsKey('title')) {
        message = responseData['title'];
      }
    }

    return DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
      error: message,
      message: message,
    );
  }

  Future<Map<String, dynamic>> _handleDioError(DioException error) async {
    // Check for 401 Unauthorized and attempt token refresh
    if (error.response?.statusCode == 401) {
      // Don't refresh for login/refresh endpoints
      if (!error.requestOptions.path.contains('/api/auth/login') &&
          !error.requestOptions.path.contains('/api/auth/refresh')) {
        // Try to refresh token
        final refreshed = await _refreshToken();

        if (refreshed) {
          // Retry the original request with new token
          try {
            final retryResponse = await request(
              _getRequestType(error.requestOptions.method),
              error.requestOptions.path,
              data: error.requestOptions.data,
              multipartData: error.requestOptions.data is FormData
                  ? (error.requestOptions.data as FormData).fields.fold<Map<String, dynamic>>({}, (map, field) {
                      map[field.key] = field.value;
                      return map;
                    })
                  : null,
            );
            return retryResponse;
          } catch (e) {
            // Retry failed, throw original error
            if (error.response != null) {
              throw _handleFailure(error.response!);
            }
          }
        }
      }
    }

    if (error.response != null) {
      throw _handleFailure(error.response!);
    } else {
      // final message = error.message ?? "Network error. Please check your connection.";
      // UTAToast.show(message: message, type: ToastificationType.error);
      throw DioException(
        requestOptions: error.requestOptions,
        error: error.error,
        type: DioExceptionType.unknown,
        response: error.response,
        message: error.message,
      );
    }
  }

  // Helper to convert method string to RequestType
  RequestType _getRequestType(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return RequestType.GET;
      case 'POST':
        return RequestType.POST;
      case 'PUT':
        return RequestType.PUT;
      case 'DELETE':
        return RequestType.DELETE;
      case 'PATCH':
        return RequestType.PATCH;
      default:
        return RequestType.POST;
    }
  }

  // Refresh token method
  Future<bool> _refreshToken() async {
    try {
      final storedRefreshToken = Prefobj.preferences?.get(Prefkeys.REFRESHTOKEN);

      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        return false;
      }

      final Map<String, dynamic> data = {"refreshToken": storedRefreshToken};

      final response = await _dio.post(
        ApiEndPoint.refreshToken,
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;

        // Update stored tokens
        if (responseData['accessToken'] != null) {
          await Prefobj.preferences?.put(Prefkeys.AUTHTOKEN, responseData['accessToken']);
        }

        if (responseData['refreshToken'] != null) {
          await Prefobj.preferences?.put(Prefkeys.REFRESHTOKEN, responseData['refreshToken']);
        }

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  // --------------------------- MULTIPART FORM BUILDER ---------------------------

  Future<FormData> _buildMultipartForm(Map<String, dynamic>? data) async {
    final formData = FormData();

    if (data == null || data.isEmpty) return formData;

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      // Support a list of file paths (List<String>)
      if (value is List && value.isNotEmpty && value.first is String) {
        for (final path in value as List<String>) {
          formData.files.add(MapEntry(key, await MultipartFile.fromFile(path)));
        }
        continue;
      }

      // Support a list of MultipartFile
      if (value is List && value.isNotEmpty && value.first is MultipartFile) {
        for (final file in value as List<MultipartFile>) {
          formData.files.add(MapEntry(key, file));
        }
        continue;
      }

      // Support a single MultipartFile
      if (value is MultipartFile) {
        formData.files.add(MapEntry(key, value));
        continue;
      }

      // Fallback to add as field
      formData.fields.add(MapEntry(key, value.toString()));
    }

    return formData;
  }
}
