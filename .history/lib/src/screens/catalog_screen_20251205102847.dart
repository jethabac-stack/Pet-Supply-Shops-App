import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  List<Product> _mockProducts() => [
        Product(id: 'p1', name: 'Dog Food - 5kg', category: 'Food', brand: 'GoodPet', price: 1999.0, stock: 12, imageUrl: ''),
        Product(id: 'p2', name: 'Cat Treats - Tuna', category: 'Treats', brand: 'Yummy', price: 149.0, stock: 34, imageUrl: ''),
