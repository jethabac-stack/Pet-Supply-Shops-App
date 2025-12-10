import 'package:flutter/material.dart';
import '../domain/entities/product.dart';
import '../providers.dart';

class ProductDetailScreen extends StatelessWidget {
  final String? productId;

  const ProductDetailScreen({super.key, required this.productId});

  Product _find(String? id) {
    // In a real app, lookup product by id. Here return a mock
    return Product(
      id: id ?? 'p1',
      name: 'Sample Product',
      description: 'Sample description',
      category: 'Food',
      brand: 'BrandX',
      price: 123.0,
      stock: 10,
      imageUrl: '',
      petTypes: ['dog'],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = _find(productId);
  final cart = CartServiceProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('${p.brand} • ${p.category}'),
          const SizedBox(height: 16),
          Text('Price: ₱${p.price.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          Text('Stock: ${p.stock}'),
          const SizedBox(height: 24),
          Row(children: [
            ElevatedButton(onPressed: () { cart.add(p); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart'))); }, child: const Text('Add to cart')),
            const SizedBox(width: 12),
            OutlinedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reminder set (mock)'))); }, child: const Text('Set Reminder')),
          ])
        ]),
      ),
    );
  }
}
