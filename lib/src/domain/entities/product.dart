import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final double price;
  final int stock;
  final String imageUrl;
  final List<String> petTypes; // e.g., ['dog', 'cat']
  final String? size;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.petTypes,
    this.size,
  });

  @override
  List<Object?> get props => [id, name, description, category, brand, price, stock, imageUrl, petTypes, size];
}
