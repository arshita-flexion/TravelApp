import 'package:flutter/material.dart';
import 'package:codefest_travel_app/features/splash/view/splash_view.dart';
import 'package:codefest_travel_app/features/onboarding/view/onboarding_view.dart';
import 'package:codefest_travel_app/features/auth/view/login_view.dart';
import 'package:codefest_travel_app/features/auth/view/otp_verification_view.dart';
import 'package:codefest_travel_app/features/home/view/search_view.dart';
import 'package:codefest_travel_app/features/home/view/package_details_view.dart';
import 'package:codefest_travel_app/features/booking/view/booking_view.dart';
import 'package:codefest_travel_app/features/profile/view/booking_history_view.dart';
import 'package:codefest_travel_app/features/profile/view/profile_view.dart';
import 'package:codefest_travel_app/features/auth/view/set_profile_view.dart';
import 'package:codefest_travel_app/features/home/view/category_packages_view.dart';
import 'package:codefest_travel_app/features/home/view/all_plans_view.dart';
import 'package:codefest_travel_app/features/bottom_navigation/bottom_navigation_view.dart';
import 'package:codefest_travel_app/features/profile/view/privacy_policy_view.dart';
import 'package:codefest_travel_app/features/profile/view/terms_and_conditions_view.dart';
import 'package:codefest_travel_app/features/profile/view/faq_view.dart';
import 'package:codefest_travel_app/features/profile/view/contact_us_view.dart';
import 'package:codefest_travel_app/models/category.dart';
import 'package:codefest_travel_app/models/plan.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String otpVerificationRoute = '/otp-verification';
  static const String bottomNavigationView = '/bottom-navigation';
  static const String searchRoute = '/search';
  static const String packageDetailsRoute = '/package-details';
  static const String bookingRoute = '/booking';
  static const String bookingHistoryRoute = '/booking-history';
  static const String profileRoute = '/profile';
  static const String setProfileRoute = '/set-profile';
  static const String categoryPackagesRoute = '/category-packages';
  static const String allPlansRoute = '/all-plans';
  static const String privacyPolicyRoute = '/privacy-policy';
  static const String termsAndConditionsRoute = '/terms-and-conditions';
  static const String faqRoute = '/faq';
  static const String contactUsRoute = '/contact-us';

  static Map<String, WidgetBuilder> get routes => {
    initialRoute: (context) => const SplashView(),
    onboardingRoute: (context) => const OnboardingView(),
    loginRoute: (context) => const LoginView(),
    bottomNavigationView: (context) => const BottomNavigationView(),
    searchRoute: (context) => const SearchView(),
    setProfileRoute: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final isEditing = args?['isEditing'] ?? false;
      return SetProfileView(isEditing: isEditing);
    },
    otpVerificationRoute: (context) {
      final email = ModalRoute.of(context)!.settings.arguments as String;
      return OtpVerificationView(email: email);
    },
    packageDetailsRoute: (context) {
      final planId = ModalRoute.of(context)!.settings.arguments as String;
      return PackageDetailsView(planId: planId);
    },
    bookingRoute: (context) {
      final plan = ModalRoute.of(context)!.settings.arguments as Plan;
      return BookingView(plan: plan);
    },
    bookingHistoryRoute: (context) => const BookingHistoryView(),
    profileRoute: (context) => const ProfileView(),
    categoryPackagesRoute: (context) {
      final category = ModalRoute.of(context)!.settings.arguments as Category;
      return CategoryPackagesView(category: category);
    },
    allPlansRoute: (context) {
      final plans = ModalRoute.of(context)!.settings.arguments as List<Plan>;
      return AllPlansView(plans: plans);
    },
    privacyPolicyRoute: (context) => const PrivacyPolicyView(),
    termsAndConditionsRoute: (context) => const TermsAndConditionsView(),
    faqRoute: (context) => const FAQView(),
    contactUsRoute: (context) => const ContactUsView(),
  };
}
