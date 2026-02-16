import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';

class TravelPackage extends Equatable {
  final String id;
  final String name;
  final String location;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;
  final List<String> images;
  final List<String> inclusions;
  final List<String> exclusions;
  final List<DateTime> availableDates;
  final double adultPrice;
  final double childPrice;

  String get fullImageUrl => ApiEndPoint.getPublicImageUrl(imageUrl);
  List<String> get fullImagesList => images.map((e) => ApiEndPoint.getPublicImageUrl(e)).toList();

  const TravelPackage({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.images,
    required this.inclusions,
    required this.exclusions,
    required this.availableDates,
    required this.adultPrice,
    required this.childPrice,
  });

  @override
  List<Object?> get props => [id, name, location, price, rating];

  factory TravelPackage.fromJson(Map<String, dynamic> json) {
    return TravelPackage(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? json['coverImage'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      inclusions: List<String>.from(json['inclusions'] ?? []),
      exclusions: List<String>.from(json['exclusions'] ?? []),
      availableDates: json['availableDates'] != null
          ? (json['availableDates'] as List).map((e) => DateTime.parse(e)).toList()
          : [],
      adultPrice: (json['adultPrice'] ?? json['price'] ?? 0).toDouble(),
      childPrice: (json['childPrice'] ?? 0).toDouble(),
    );
  }
}
