import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/models/user.dart';
import 'package:codefest_travel_app/core/utils/logger.dart';
import 'package:codefest_travel_app/core/utils/local_storage/local_storage.dart';
import 'package:codefest_travel_app/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<LoginWithEmailRequested>(_onLoginWithEmailRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<ResendOtpRequested>(_onResendOtpRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginWithEmailRequested(LoginWithEmailRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authRepository.login(email: event.email);
      if (result['message'] != null) {
        emit(state.copyWith(status: AuthStatus.otpSent, email: event.email));
      } else {
        emit(state.copyWith(status: AuthStatus.error, errorMessage: 'Failed to send OTP'));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onVerifyOtpRequested(VerifyOtpRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authRepository.verifyOtp(email: event.email, otp: event.otp);
      
      if (result['token'] != null && result['user'] != null) {
        final user = UserProfile.fromJson(result['user']);
        final token = result['token'];
        final isProfileIncomplete = result['isProfileIncomplete'] ?? false;

        // Persist auth token
        await Prefobj.preferences?.put(Prefkeys.AUTHTOKEN, token);

        if (isProfileIncomplete) {
          emit(state.copyWith(status: AuthStatus.profileIncomplete, user: user, token: token));
        } else {
          emit(state.copyWith(status: AuthStatus.authenticated, user: user, token: token));
        }
      } else {
        emit(state.copyWith(status: AuthStatus.error, errorMessage: 'Login failed'));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateProfileRequested(UpdateProfileRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await authRepository.updateProfile(
        name: event.name,
        mobileNumber: event.mobileNumber,
        profession: event.profession,
        profileImage: event.profileImage,
      );

      if (result['user'] != null) {
        final updatedUser = UserProfile.fromJson(result['user']);
        emit(state.copyWith(status: AuthStatus.authenticated, user: updatedUser));
      } else {
        emit(state.copyWith(status: AuthStatus.error, errorMessage: result['message'] ?? 'Failed to update profile'));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onResendOtpRequested(ResendOtpRequested event, Emitter<AuthState> emit) async {
    try {
      await authRepository.login(email: event.email);
    } catch (e) {
      Logger.lOG('Resend OTP error: $e');
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await OptimizedStorage.clearExceptOnboarding();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
