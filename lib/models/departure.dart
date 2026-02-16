import 'package:equatable/equatable.dart';

class Departure extends Equatable {
  final String id;
  final String planId;
  final DateTime startDate;
  final DateTime endDate;
  final int seatsTotal;
  final int seatsBooked;
  final bool isActive;
  final String availabilityStatus;
  final int availableSeats;

  const Departure({
    required this.id,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.seatsTotal,
    required this.seatsBooked,
    required this.isActive,
    required this.availabilityStatus,
    required this.availableSeats,
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      id: json['_id'] ?? '',
      planId: json['planId'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      seatsTotal: json['seatsTotal'] ?? 0,
      seatsBooked: json['seatsBooked'] ?? 0,
      isActive: json['isActive'] ?? true,
      availabilityStatus: json['availability']?['status'] ?? 'unknown',
      availableSeats: json['availability']?['availableSeats'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, planId, startDate, endDate, seatsTotal, seatsBooked];
}
