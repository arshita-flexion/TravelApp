import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/models/travel_package.dart';
import 'package:codefest_travel_app/models/category.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/repository/travel_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TravelRepository travelRepository;

  HomeBloc({required this.travelRepository}) : super(const HomeState()) {
    on<LoadHomeDataRequested>(_onLoadHomeDataRequested);
    on<SearchPackagesRequested>(_onSearchPackagesRequested);
  }

  Future<void> _onLoadHomeDataRequested(LoadHomeDataRequested event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final results = await Future.wait([
        travelRepository.getPackages(),
        travelRepository.getCategories(),
        travelRepository.getPlans(),
        travelRepository.getUpcomingPlans(),
      ]);
      final packages = results[0] as List<TravelPackage>;
      final categories = results[1] as List<Category>;
      final plans = results[2] as List<Plan>;
      final upcomingPlans = results[3] as List<Plan>;
      emit(state.copyWith(
        status: HomeStatus.success,
        packages: packages,
        trendingPackages: packages.take(5).toList(),
        categories: categories,
        plans: plans,
        upcomingPlans: upcomingPlans,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSearchPackagesRequested(SearchPackagesRequested event, Emitter<HomeState> emit) async {
    emit(state.copyWith(searchQuery: event.query));
    if (event.query.isEmpty) {
      emit(state.copyWith(searchResults: [], planSearchResults: []));
      return;
    }
    
    try {
      final plans = await travelRepository.searchPlans(event.query);
      emit(state.copyWith(planSearchResults: plans));
    } catch (e) {
      // Handle search error silently or update state
    }
  }
}
