import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  List<Product> _mockProducts() => [
        Product(id: 'p1', name: 'Dog Food - 5kg', category: 'Food', brand: 'GoodPet', price: 1999.0, stock: 12, imageUrl: ''),
        Product(id: 'p2', name: 'Cat Treats - Tuna', category: 'Treats', brand: 'Yummy', price: 149.0, stock: 34, imageUrl: ''),
        Product(id: 'p3', name: 'Shampoo - All Pets', category: 'Grooming', brand: 'CleanCo', price: 299.0, stock: 5, imageUrl: ''),
      ];

  @override
  Widget build(BuildContext context) {
    final products = _mockProducts();
    final cart = CartServiceProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Catalog'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) {
            final p = products[i];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
