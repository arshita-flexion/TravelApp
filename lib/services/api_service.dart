import 'dart:async';
import 'package:codefest_travel_app/models/travel_package.dart';
import 'package:codefest_travel_app/models/booking.dart';
import 'package:codefest_travel_app/models/user.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Mock data
  final List<TravelPackage> _mockPackages = [
    TravelPackage(
      id: '1',
      name: 'Bali Tropical Paradise',
      location: 'Bali, Indonesia',
      description:
          'Experience the magic of Bali with its stunning beaches, vibrant culture, and lush landscapes. This 5-day tour covers the best of Ubud and Seminyak.',
      price: 899.0,
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
      images: [
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
        'https://images.unsplash.com/photo-1537953391648-762d3085eeea',
        'https://images.unsplash.com/photo-1502759683299-cdcc6974244f',
      ],
      inclusions: ['Flight tickets', '4-star Hotel', 'Daily Breakfast', 'Guided Tours'],
      exclusions: ['Lunch and Dinner', 'Personal Expenses', 'Visa Fees'],
      availableDates: [
        DateTime.now().add(const Duration(days: 7)),
        DateTime.now().add(const Duration(days: 14)),
        DateTime.now().add(const Duration(days: 21)),
      ],
      adultPrice: 899.0,
      childPrice: 499.0,
    ),
    TravelPackage(
      id: '2',
      name: 'Swiss Alps Adventure',
      location: 'Interlaken, Switzerland',
      description:
          'A breathtaking journey through the heart of the Swiss Alps. Enjoy mountain peaks, crystal clear lakes, and charming villages.',
      price: 1299.0,
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
      images: [
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
        'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1',
      ],
      inclusions: ['Mountain Rail Pass', 'Alps Resort Stay', 'Equipment Rentals'],
      exclusions: ['Meals', 'Insurance'],
      availableDates: [DateTime.now().add(const Duration(days: 10)), DateTime.now().add(const Duration(days: 20))],
      adultPrice: 1299.0,
      childPrice: 899.0,
    ),
    TravelPackage(
      id: '3',
      name: 'Santorini Sunset Tour',
      location: 'Oia, Greece',
      description:
          'Witness the most beautiful sunsets in the world. Explore the white-washed buildings and blue domes of Santorini.',
      price: 950.0,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-11506905925346-21bda4d32df4', // Fixed URL if needed but using placeholder-like
      images: ['https://images.unsplash.com/photo-1516483638261-f4dbaf036963'],
      inclusions: ['Ferry Transfers', 'Boutique Hotel', 'Sunset Dinner'],
      exclusions: ['Tips', 'Shopping'],
      availableDates: [DateTime.now().add(const Duration(days: 5)), DateTime.now().add(const Duration(days: 15))],
      adultPrice: 950.0,
      childPrice: 600.0,
    ),
  ];

  final List<Booking> _mockBookings = [];
  UserProfile? _currentUser;

  // --- Auth APIs ---

  Future<bool> login(String mobile) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Always succeeds for mock
  }

  Future<Map<String, dynamic>> verifyOtp(String mobile, String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = UserProfile(
      id: 'user_1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      mobileNumber: mobile,
      profileImage: 'https://ui-avatars.com/api/?name=John+Doe',
    );
    return {'token': 'mock_token_12345', 'user': _currentUser!.toJson()};
  }

  Future<bool> signUp(String name, String email, String mobile) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // --- Package APIs ---

  Future<List<TravelPackage>> getPackages() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockPackages;
  }

  Future<List<TravelPackage>> searchPackages(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) return _mockPackages;
    return _mockPackages
        .where(
          (p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.location.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<TravelPackage?> getPackageDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockPackages.firstWhere((p) => p.id == id);
  }

  // --- Booking APIs ---

  Future<List<DateTime>> getAvailableDates(String packageId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final package = _mockPackages.firstWhere((p) => p.id == packageId);
    return package.availableDates;
  }

  Future<bool> checkAvailability(String packageId, DateTime date) async {
    await Future.delayed(const Duration(seconds: 1));
    // Implementation logic... for mock, middle of the week is unavailable sometimes?
    return true;
  }

  Future<Booking> bookTrip(Booking booking) async {
    await Future.delayed(const Duration(seconds: 2));
    final newBooking = Booking(
      id: 'BK-${DateTime.now().millisecondsSinceEpoch}',
      packageId: booking.packageId,
      packageName: booking.packageName,
      date: booking.date,
      adults: booking.adults,
      children: booking.children,
      totalAmount: booking.totalAmount,
      status: BookingStatus.confirmed,
      userName: booking.userName,
      email: booking.email,
      mobile: booking.mobile,
    );
    _mockBookings.add(newBooking);
    return newBooking;
  }

  Future<List<Booking>> getBookingHistory() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockBookings;
  }

  // --- Profile APIs ---

  Future<UserProfile?> getProfileData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _currentUser;
  }
}
