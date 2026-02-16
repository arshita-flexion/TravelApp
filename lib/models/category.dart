import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String? coverImage;
  final List<String> images;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.coverImage,
    required this.images,
    required this.isActive,
  });

  String get fullCoverImageUrl => ApiEndPoint.getPublicImageUrl(coverImage);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      coverImage: json['coverImage'],
      images: List<String>.from(json['images'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }

  @override
  List<Object?> get props => [id, name, slug, coverImage, isActive];
}
