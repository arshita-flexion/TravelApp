import 'package:equatable/equatable.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';

class UserProfile extends Equatable {
  final String id;
  final String? name;
  final String email;
  final String? mobileNumber;
  final String? profileImage;
  final String? role;
  final String? profession;

  String? get fullProfileImageUrl {
    final url = ApiEndPoint.getPublicImageUrl(profileImage);
    return url.isEmpty ? null : url;
  }

  const UserProfile({
    required this.id,
    this.name,
    required this.email,
    this.mobileNumber,
    this.profileImage,
    this.role,
    this.profession,
  });

  @override
  List<Object?> get props => [id, email, mobileNumber, role, profession, profileImage];

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Handle both 'id' and '_id' from different API versions or Mongo responses
    String extractId(dynamic idObj) {
      if (idObj is String) return idObj;
      if (idObj is Map && idObj.containsKey('\$oid')) return idObj['\$oid'];
      return '';
    }

    return UserProfile(
      id: extractId(json['id'] ?? json['_id']),
      name: json['name'],
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'],
      profileImage: json['profileImage'],
      role: json['role'],
      profession: json['profession'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'profileImage': profileImage,
      'role': role,
      'profession': profession,
    };
  }

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? mobileNumber,
    String? profileImage,
    String? role,
    String? profession,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      profession: profession ?? this.profession,
    );
  }
}
