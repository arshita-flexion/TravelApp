import 'package:equatable/equatable.dart';

enum BookingStatus { pending, confirmed, completed, cancelled }

class Booking extends Equatable {
  final String id;
  final String? bookingCode;
  final String packageId;
  final String packageName;
  final DateTime date;
  final int adults;
  final int children;
  final double totalAmount;
  final BookingStatus status;
  final String? userName;
  final String? email;
  final String? mobile;
  final String? notes;

  const Booking({
    required this.id,
    this.bookingCode,
    required this.packageId,
    required this.packageName,
    required this.date,
    required this.adults,
    required this.children,
    required this.totalAmount,
    required this.status,
    this.userName,
    this.email,
    this.mobile,
    this.notes,
  });

  @override
  List<Object?> get props => [id, bookingCode, packageId, date, status];

  factory Booking.fromJson(Map<String, dynamic> json) {
    String statusStr = json['bookingStatus'] ?? json['status'] ?? 'pending';
    BookingStatus statusEnum = BookingStatus.pending;
    try {
      statusEnum = BookingStatus.values.firstWhere((e) => e.name == statusStr);
    } catch (_) {}

    return Booking(
      id: json['_id'] ?? json['id'] ?? '',
      bookingCode: json['bookingCode'],
      packageId: json['planId'] is Map ? (json['planId']['_id'] ?? '') : (json['planId'] ?? json['packageId'] ?? ''),
      packageName: json['planNameSnapshot'] ?? (json['planId'] is Map ? json['planId']['name'] : 'Unknown Package'),
      date: DateTime.parse(json['createdAt'] ?? json['date'] ?? DateTime.now().toIso8601String()),
      adults: json['adultCount'] ?? json['adults'] ?? 0,
      children: json['childCount'] ?? json['children'] ?? 0,
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: statusEnum,
      userName: json['contactName'] ?? json['userName'],
      email: json['contactEmail'] ?? json['email'],
      mobile: json['contactMobile'] ?? json['mobile'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingCode': bookingCode,
      'packageId': packageId,
      'packageName': packageName,
      'date': date.toIso8601String(),
      'adults': adults,
      'children': children,
      'totalAmount': totalAmount,
      'status': status.name,
      'userName': userName,
      'email': email,
      'mobile': mobile,
      'notes': notes,
    };
  }
}
