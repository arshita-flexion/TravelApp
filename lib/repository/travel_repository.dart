import 'package:codefest_travel_app/models/travel_package.dart';
import 'package:codefest_travel_app/models/booking.dart';
import 'package:codefest_travel_app/models/category.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/models/user.dart';
import 'package:codefest_travel_app/services/api_service.dart';
import 'package:codefest_travel_app/core/api_config/client/api_client.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';

class TravelRepository {
  final ApiService apiService;
  final ApiClient apiClient;

  TravelRepository({required this.apiService, required this.apiClient});

  Future<List<TravelPackage>> getPackages() async {
    return await apiService.getPackages();
  }

  Future<List<Category>> getCategories() async {
    final response = await apiClient.request(RequestType.GET, ApiEndPoint.categories);
    if (response['categories'] != null) {
      return (response['categories'] as List).map((e) => Category.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Plan>> getPlans() async {
    final response = await apiClient.request(RequestType.GET, ApiEndPoint.plans);
    if (response['plans'] != null) {
      return (response['plans'] as List).map((e) => Plan.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<Plan>> getUpcomingPlans() async {
    final response = await apiClient.request(RequestType.GET, ApiEndPoint.upcomingPlans);
    if (response['plans'] != null) {
      return (response['plans'] as List).map((e) => Plan.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<TravelPackage>> searchPackages(String query) async {
    return await apiService.searchPackages(query);
  }

  Future<List<Plan>> searchPlans(String query) async {
    final response = await apiClient.request(RequestType.GET, ApiEndPoint.searchPlans(query));
    if (response['plans'] != null) {
      return (response['plans'] as List).map((e) => Plan.fromJson(e)).toList();
    }
    return [];
  }

  Future<TravelPackage?> getPackageDetails(String id) async {
    return await apiService.getPackageDetails(id);
  }

  Future<List<DateTime>> getAvailableDates(String packageId) async {
    return await apiService.getAvailableDates(packageId);
  }

  Future<bool> checkAvailability(String packageId, DateTime date) async {
    return await apiService.checkAvailability(packageId, date);
  }

  Future<Booking> bookTrip(Booking booking) async {
    return await apiService.bookTrip(booking);
  }

  Future<List<Booking>> getBookingHistory() async {
    final response = await apiClient.request(RequestType.GET, ApiEndPoint.bookingHistory);
    if (response['bookings'] != null) {
      return (response['bookings'] as List).map((e) => Booking.fromJson(e)).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> bookingData) async {
    return await apiClient.request(RequestType.POST, ApiEndPoint.bookings, data: bookingData);
  }

  Future<UserProfile?> getProfileData() async {
    final response = await apiClient.request(RequestType.GET, ApiEndPoint.profile);
    if (response['user'] != null) {
      return UserProfile.fromJson(response['user']);
    }
    return null;
  }
}
