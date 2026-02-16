part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, otpSent, profileIncomplete, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserProfile? user;
  final String? token;
  final String? errorMessage;
  final String? email;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.token,
    this.errorMessage,
    this.email,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserProfile? user,
    String? token,
    String? errorMessage,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, user, token, errorMessage, email];
}
