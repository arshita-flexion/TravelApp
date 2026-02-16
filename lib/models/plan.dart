import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';
import 'package:codefest_travel_app/models/departure.dart';

class Plan extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String shortDescription;
  final String description;
  final int durationDays;
  final double basePrice;
  final double adultPrice;
  final double childPrice;
  final String currency;
  final List<String> images;
  final List<DateTime> startDates;
  final List<Departure> departures;
  final String? categoryName;
  final String? categoryId;
  final bool isActive;

  const Plan({
    required this.id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.description,
    required this.durationDays,
    required this.basePrice,
    required this.adultPrice,
    required this.childPrice,
    required this.currency,
    required this.images,
    required this.startDates,
    required this.departures,
    this.categoryName,
    this.categoryId,
    required this.isActive,
  });

  String get fullCoverImageUrl =>
      images.isNotEmpty ? ApiEndPoint.getPublicImageUrl(images.first) : '';

  List<String> get fullImagesList =>
      images.map((e) => ApiEndPoint.getPublicImageUrl(e)).toList();

  String get formattedPrice => '$currency ${basePrice.toStringAsFixed(0)}';

  String get formattedAdultPrice => '$currency ${adultPrice.toStringAsFixed(0)}';

  String get formattedChildPrice => '$currency ${childPrice.toStringAsFixed(0)}';

  String get durationText => '$durationDays Days';

  /// Get the next upcoming departure
  Departure? get nextDeparture {
    final upcoming = departures.where((d) => d.availabilityStatus == 'upcoming').toList();
    if (upcoming.isNotEmpty) return upcoming.first;
    final ongoing = departures.where((d) => d.availabilityStatus == 'ongoing').toList();
    if (ongoing.isNotEmpty) return ongoing.first;
    return departures.isNotEmpty ? departures.first : null;
  }

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      description: json['description'] ?? '',
      durationDays: json['durationDays'] ?? 0,
      basePrice: (json['basePrice'] ?? json['adultPrice'] ?? 0).toDouble(),
      adultPrice: (json['adultPrice'] ?? json['basePrice'] ?? 0).toDouble(),
      childPrice: (json['childPrice'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'INR',
      images: List<String>.from(json['images'] ?? []),
      startDates: json['startDates'] != null
          ? (json['startDates'] as List).map((e) => DateTime.parse(e)).toList()
          : [],
      departures: json['departures'] != null
          ? (json['departures'] as List).map((e) => Departure.fromJson(e)).toList()
          : [],
      categoryName: json['categoryId'] is Map ? json['categoryId']['name'] : null,
      categoryId: json['categoryId'] is Map ? json['categoryId']['_id'] : json['categoryId'],
      isActive: json['isActive'] ?? true,
    );
  }

  @override
  List<Object?> get props => [id, name, slug, basePrice, durationDays];
}
