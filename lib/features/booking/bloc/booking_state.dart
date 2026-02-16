part of 'booking_bloc.dart';

enum BookingStep { tripDetails, personalDetails, success }

enum BookingBlocStatus { initial, checking, booking, success, error }

class BookingState extends Equatable {
  final BookingStep currentStep;
  final BookingBlocStatus status;
  final String packageId;
  final DateTime? selectedDate;
  final int adults;
  final int children;
  final double totalAmount;
  final Booking? confirmedBooking;
  final String? errorMessage;

  const BookingState({
    required this.packageId,
    this.currentStep = BookingStep.tripDetails,
    this.status = BookingBlocStatus.initial,
    this.selectedDate,
    this.adults = 1,
    this.children = 0,
    this.totalAmount = 0,
    this.confirmedBooking,
    this.errorMessage,
  });

  BookingState copyWith({
    BookingStep? currentStep,
    BookingBlocStatus? status,
    String? packageId,
    DateTime? selectedDate,
    int? adults,
    int? children,
    double? totalAmount,
    Booking? confirmedBooking,
    String? errorMessage,
  }) {
    return BookingState(
      packageId: packageId ?? this.packageId,
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      totalAmount: totalAmount ?? this.totalAmount,
      confirmedBooking: confirmedBooking ?? this.confirmedBooking,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    status,
    packageId,
    selectedDate,
    adults,
    children,
    totalAmount,
    confirmedBooking,
    errorMessage,
  ];
}
