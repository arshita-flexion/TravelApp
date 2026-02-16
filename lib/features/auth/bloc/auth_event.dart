part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailRequested extends AuthEvent {
  final String email;
  const LoginWithEmailRequested(this.email);

  @override
  List<Object> get props => [email];
}

class VerifyOtpRequested extends AuthEvent {
  final String email;
  final String otp;
  const VerifyOtpRequested(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}

class ResendOtpRequested extends AuthEvent {
  final String email;
  const ResendOtpRequested(this.email);

  @override
  List<Object> get props => [email];
}

class LogoutRequested extends AuthEvent {}

class UpdateProfileRequested extends AuthEvent {
  final String? name;
  final String? mobileNumber;
  final String? profession;
  final String? profileImage;

  const UpdateProfileRequested({
    this.name,
    this.mobileNumber,
    this.profession,
    this.profileImage,
  });

  @override
  List<Object> get props => [
        name ?? '',
        mobileNumber ?? '',
        profession ?? '',
        profileImage ?? '',
      ];
}
