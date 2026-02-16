import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/core/utils/local_storage/local_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(SplashStarted event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    
    final authToken = Prefobj.preferences?.get(Prefkeys.AUTHTOKEN);
    final onboardingDone = Prefobj.preferences?.get(Prefkeys.ONBOARDING) == true;

    if (authToken == null) {
      if (onboardingDone) {
        emit(state.copyWith(status: SplashStatus.navigateToLogin));
      } else {
        emit(state.copyWith(status: SplashStatus.navigateToOnboarding));
      }
    } else {
      emit(state.copyWith(status: SplashStatus.navigateToHome));
    }
  }
}
