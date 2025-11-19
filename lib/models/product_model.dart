class ProductModel {
  final String id;
  final String name;
  final String price;
  final String rating;
  final String reviews;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      reviews: map['reviews'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
