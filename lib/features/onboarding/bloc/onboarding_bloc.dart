import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/core/utils/local_storage/local_storage.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingPageChanged>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
    on<OnboardingFinished>((event, emit) {
      Prefobj.preferences?.put(Prefkeys.ONBOARDING, true);
    });
  }
}
