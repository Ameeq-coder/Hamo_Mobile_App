class ServiceDetail {
  final String id;
  final String name;
  final String serviceHead;
  final String category;
  final String location;
  final int price;
  final String about;
  final String imageUrl;

  ServiceDetail({
    required this.id,
    required this.name,
    required this.serviceHead,
    required this.category,
    required this.location,
    required this.price,
    required this.about,
    required this.imageUrl,
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
    return ServiceDetail(
      name: json['name'],
      serviceHead: json['serviceHead'],
      category: json['category'],
      location: json['location'],
      price: json['price'],
      about: json['about'],
      imageUrl: json['imageUrl'], id: json['servicemanId'],
    );
  }
}
