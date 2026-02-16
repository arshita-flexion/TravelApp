import 'package:dio/dio.dart';
import 'package:codefest_travel_app/models/user.dart';
import 'package:codefest_travel_app/core/api_config/client/api_client.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';

class AuthRepository {
  final ApiClient apiClient;
  
  AuthRepository({required this.apiClient});

  Future<Map<String, dynamic>> login({required String email}) async {
    return await apiClient.request(
      RequestType.POST,
      ApiEndPoint.login,
      data: {"email": email},
    );
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await apiClient.request(
      RequestType.POST,
      ApiEndPoint.verifyOtp,
      data: {
        "email": email,
        "otp": otp,
      },
    );
  }

  Future<UserProfile?> getProfileData() async {
    try {
      final response = await apiClient.request(
        RequestType.GET,
        ApiEndPoint.profile,
      );
      if (response['user'] != null) {
        return UserProfile.fromJson(response['user']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? mobileNumber,
    String? profession,
    String? profileImage,
  }) async {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (mobileNumber != null) data['mobileNumber'] = mobileNumber;
    if (profession != null) data['profession'] = profession;

    if (profileImage != null && !profileImage.startsWith('http')) {
      // Local file path
      data['profileImage'] = await MultipartFile.fromFile(profileImage);
      return await apiClient.request(
        RequestType.MULTIPART_PUT,
        ApiEndPoint.profile,
        multipartData: data,
      );
    }

    if (profileImage != null) data['profileImage'] = profileImage;

    return await apiClient.request(
      RequestType.PUT,
      ApiEndPoint.profile,
      data: data,
    );
  }
}
