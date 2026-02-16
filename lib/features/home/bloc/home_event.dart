part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeDataRequested extends HomeEvent {}

class SearchPackagesRequested extends HomeEvent {
  final String query;
  const SearchPackagesRequested(this.query);

  @override
  List<Object> get props => [query];
}
