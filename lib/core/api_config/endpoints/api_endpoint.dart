import 'package:codefest_travel_app/core/flavor_config/flavor_config.dart';

class ApiEndPoint {
  static String get baseUrl => FlavorConfig.instance.env.baseUrl;

  static String get login => "$baseUrl/api/public/auth/login";
  static String get verifyOtp => "$baseUrl/api/public/auth/user/login/verify-otp";
  static String get logout => "$baseUrl/api/public/auth/logout";
  static String get profile => "$baseUrl/api/private/auth/profile";
  static String get refreshToken => "$baseUrl/api/public/auth/refresh";
  static String get categories => "$baseUrl/api/public/categories";
  static String get plans => "$baseUrl/api/public/plans";
  static String get upcomingPlans => "$baseUrl/api/public/plans/upcoming";
  static String searchPlans(String query) => "$baseUrl/api/public/plans/search?q=$query";
  static String planDetails(String id) => "$baseUrl/api/public/plans/details/$id";
  static String get publicImageUrl => "$baseUrl/api/images/public";
  static String get bookings => "$baseUrl/api/public/bookings";
  static String get bookingHistory => "$baseUrl/api/public/bookings/history";

  static String getPublicImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith('http')) return path;
    return "$publicImageUrl/$path";
  }
}
