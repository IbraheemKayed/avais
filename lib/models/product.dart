import 'dart:convert';

class Product {
  final String title;
  final String description;
  final double quantity;
  final String image_url;
  final List<String> categories;
  final double price;
  final String? id;
  final String? rating;
  final Map<String , List<String>> attributes;
  final String stock_status;
  final int stock_quantity;
  //final List<String?> gallery_images;
  Product({
    required this.title,
    required this.description,
    required this.quantity,
    required this.image_url,
    required this.categories,
    required this.price,
    this.rating,
    this.id,
    required this.attributes,
    //required this.gallery_images,
    required this.stock_quantity,
    required this.stock_status,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'quantity': quantity,
      'image_url': image_url,
      'categories': categories,
      'price': price,
      'id': id,
      'rating': rating,
      'attributes': attributes,
      //'gallery_images': gallery_images,
      'stock_quantity': stock_quantity,
      'stock_status': stock_status,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
  Map<String, List<String>> attributesMap = {};
  if (map['attributes'] != null) {
    for (var key in map['attributes'].keys) {
      attributesMap[key] = List<String>.from(map['attributes'][key]);
    }
  }

  // Handle the 'gallery_images' property, which may have mixed types or be null
  List<String?> galleryImagesList = [];
  final galleryImages = map['gallery_images'];
  if (galleryImages is List) {
    for (var item in galleryImages) {
      if (item is String) {
        galleryImagesList.add(item);
      } else {
        galleryImagesList.add(null); // Handle other data types gracefully
      }
    }
  }

  return Product(
    title: map['title'] ?? '',
    description: map['description'] ?? '',
    quantity: map['quantity']?.toDouble() ?? 0.0,
    image_url: map['image_url'] ?? '',
    categories: map['categories'],
    price: map['price']?.toDouble() ?? 0.0,
    id: map['_id'],
    attributes: attributesMap,
    rating: map['rating'] ?? '',
    //gallery_images: galleryImagesList,
    stock_quantity: map['stock_quantity']?.toDouble() ?? 0.0,
    stock_status: map['stock_status'] ?? '',
  );
}

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
