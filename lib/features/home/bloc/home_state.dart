part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<TravelPackage> packages;
  final List<TravelPackage> trendingPackages;
  final List<TravelPackage> searchResults;
  final List<Plan> planSearchResults;
  final List<Category> categories;
  final List<Plan> plans;
  final List<Plan> upcomingPlans;
  final String? errorMessage;
  final String searchQuery;

  const HomeState({
    this.status = HomeStatus.initial,
    this.packages = const [],
    this.trendingPackages = const [],
    this.searchResults = const [],
    this.planSearchResults = const [],
    this.categories = const [],
    this.plans = const [],
    this.upcomingPlans = const [],
    this.errorMessage,
    this.searchQuery = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<TravelPackage>? packages,
    List<TravelPackage>? trendingPackages,
    List<TravelPackage>? searchResults,
    List<Plan>? planSearchResults,
    List<Category>? categories,
    List<Plan>? plans,
    List<Plan>? upcomingPlans,
    String? errorMessage,
    String? searchQuery,
  }) {
    return HomeState(
      status: status ?? this.status,
      packages: packages ?? this.packages,
      trendingPackages: trendingPackages ?? this.trendingPackages,
      searchResults: searchResults ?? this.searchResults,
      planSearchResults: planSearchResults ?? this.planSearchResults,
      categories: categories ?? this.categories,
      plans: plans ?? this.plans,
      upcomingPlans: upcomingPlans ?? this.upcomingPlans,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        packages,
        trendingPackages,
        searchResults,
        planSearchResults,
        categories,
        plans,
        upcomingPlans,
        errorMessage,
        searchQuery,
      ];
}
