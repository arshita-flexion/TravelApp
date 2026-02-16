part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileRequested extends ProfileEvent {}

class UpdateProfileRequested extends ProfileEvent {
  final UserProfile updatedUser;
  const UpdateProfileRequested(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}
