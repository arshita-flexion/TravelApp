part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class CheckAvailabilityRequested extends BookingEvent {
  final String packageId;
  final DateTime date;
  final int adults;
  final int children;

  const CheckAvailabilityRequested({
    required this.packageId,
    required this.date,
    required this.adults,
    required this.children,
  });

  @override
  List<Object?> get props => [packageId, date, adults, children];
}

class PersonalDetailsSubmitted extends BookingEvent {
  final String name;
  final String email;
  final String mobile;

  const PersonalDetailsSubmitted({
    required this.name,
    required this.email,
    required this.mobile,
  });

  @override
  List<Object?> get props => [name, email, mobile];
}

class ResetBooking extends BookingEvent {}
