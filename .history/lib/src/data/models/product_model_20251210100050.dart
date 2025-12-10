import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.brand,
    required super.price,
    required super.stock,
    required super.imageUrl,
    required super.petTypes,
    super.size,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final petTypesDynamic = json['petTypes'];
    final petTypes = petTypesDynamic is List ? petTypesDynamic.map((e) => e as String).toList() : <String>[];

    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      petTypes: petTypes,
      size: json['size'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
      'petTypes': petTypes,
      'size': size,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      category: product.category,
      brand: product.brand,
      price: product.price,
      stock: product.stock,
      imageUrl: product.imageUrl,
      petTypes: product.petTypes,
      size: product.size,
    );
  }
}
