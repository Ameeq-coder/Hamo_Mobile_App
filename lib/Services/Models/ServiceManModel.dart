// models/all_servicemen_location_and_cat.dart
class AllServicemenLocationAndCat {
  final String id;
  final String servicemanId;
  final String name;
  final String serviceHead;
  final String category;
  final String location;
  final int price;
  final String about;
  final String imageUrl;
  final String email;
  final String serviceType;

  AllServicemenLocationAndCat({
    required this.id,
    required this.servicemanId,
    required this.name,
    required this.serviceHead,
    required this.category,
    required this.location,
    required this.price,
    required this.about,
    required this.imageUrl,
    required this.email,
    required this.serviceType,
  });

  factory AllServicemenLocationAndCat.fromJson(Map<String, dynamic> json) {
    return AllServicemenLocationAndCat(
      id: json['id'] ?? '',
      servicemanId: json['servicemanId'] ?? '',
      name: json['name'] ?? '',
      serviceHead: json['serviceHead'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? 0,
      about: json['about'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      email: json['serviceman']?['email'] ?? '',
      serviceType: json['serviceman']?['serviceType'] ?? '',
    );
  }
}
