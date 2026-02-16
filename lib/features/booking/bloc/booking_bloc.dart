import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/models/booking.dart';
import 'package:codefest_travel_app/models/travel_package.dart';
import 'package:codefest_travel_app/repository/travel_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final TravelRepository travelRepository;
  final TravelPackage package;

  BookingBloc({required this.travelRepository, required this.package})
    : super(BookingState(packageId: package.id, totalAmount: package.adultPrice)) {
    on<CheckAvailabilityRequested>(_onCheckAvailabilityRequested);
    on<PersonalDetailsSubmitted>(_onPersonalDetailsSubmitted);
  }

  Future<void> _onCheckAvailabilityRequested(CheckAvailabilityRequested event, Emitter<BookingState> emit) async {
    emit(state.copyWith(status: BookingBlocStatus.checking));
    try {
      final available = await travelRepository.checkAvailability(event.packageId, event.date);
      if (available) {
        emit(
          state.copyWith(
            status: BookingBlocStatus.initial,
            currentStep: BookingStep.personalDetails,
            selectedDate: event.date,
            adults: event.adults,
            children: event.children,
            totalAmount: (package.adultPrice * event.adults) + (package.childPrice * event.children),
          ),
        );
      } else {
        emit(state.copyWith(status: BookingBlocStatus.error, errorMessage: 'Date no longer available'));
      }
    } catch (e) {
      emit(state.copyWith(status: BookingBlocStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onPersonalDetailsSubmitted(PersonalDetailsSubmitted event, Emitter<BookingState> emit) async {
    emit(state.copyWith(status: BookingBlocStatus.booking));
    try {
      final booking = Booking(
        id: 'BK${DateTime.now().millisecondsSinceEpoch}',
        packageId: package.id,
        packageName: package.name,
        date: state.selectedDate!,
        adults: state.adults,
        children: state.children,
        totalAmount: state.totalAmount,
        status: BookingStatus.confirmed,
        userName: event.name,
        email: event.email,
        mobile: event.mobile,
      );

      final confirmed = await travelRepository.bookTrip(booking);
      emit(
        state.copyWith(
          status: BookingBlocStatus.success,
          currentStep: BookingStep.success,
          confirmedBooking: confirmed,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BookingBlocStatus.error, errorMessage: e.toString()));
    }
  }
}
