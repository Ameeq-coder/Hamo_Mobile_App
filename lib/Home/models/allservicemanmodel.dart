class AllServiceman {
  final String id;
  final String name;
  final String serviceHead;
  final String category;
  final String location;
  final int price;
  final String about;
  final String imageUrl;
  final String serviceType;

  AllServiceman({
    required this.id,
    required this.name,
    required this.serviceHead,
    required this.category,
    required this.location,
    required this.price,
    required this.about,
    required this.imageUrl,
    required this.serviceType,
  });

  factory AllServiceman.fromJson(Map<String, dynamic> json) {
    return AllServiceman(
      id: json['id'],
      name: json['name'],
      serviceHead: json['serviceHead'],
      category: json['category'],
      location: json['location'],
      price: json['price'],
      about: json['about'],
      imageUrl: json['imageUrl'],
      serviceType: json['serviceman']['serviceType'],
    );
  }
}