import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/models/user.dart';
import 'package:codefest_travel_app/models/booking.dart';
import 'package:codefest_travel_app/repository/travel_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final TravelRepository travelRepository;

  ProfileBloc({required this.travelRepository}) : super(const ProfileState()) {
    on<LoadProfileRequested>(_onLoadProfileRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
  }

  Future<void> _onLoadProfileRequested(LoadProfileRequested event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final results = await Future.wait([
        travelRepository.getBookingHistory(),
        travelRepository.getProfileData(),
      ]);
      
      final history = results[0] as List<Booking>;
      final user = results[1] as UserProfile?;
      
      emit(state.copyWith(
        status: ProfileStatus.success, 
        bookingHistory: history,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateProfileRequested(UpdateProfileRequested event, Emitter<ProfileState> emit) async {
    // Logic for updating profile
  }
}
