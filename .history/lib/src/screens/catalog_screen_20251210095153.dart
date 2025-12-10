import 'package:flutter/material.dart';
import '../domain/entities/product.dart';
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
      appBar: AppBar(title: const Text('Shop Catalog'), actions: [IconButton(onPressed: () => Navigator.pushNamed(context, '/cart'), icon: const Icon(Icons.shopping_cart))]),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          final p = products[i];
          return ListTile(
            title: Text(p.name),
            subtitle: Text('${p.category} • ${p.brand}'),
            trailing: Text('₱${p.price.toStringAsFixed(0)}'),
            onTap: () => Navigator.pushNamed(context, '/product', arguments: {'id': p.id}),
            onLongPress: () {
              cart.add(p);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
            },
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Pet Supplies')),
            ListTile(title: const Text('Pet Profile'), onTap: () => Navigator.pushNamed(context, '/pet-profile')),
            ListTile(title: const Text('Reminders'), onTap: () => Navigator.pushNamed(context, '/reminders')),
            ListTile(title: const Text('Logout'), onTap: () => Navigator.pushReplacementNamed(context, '/')),
          ],
        ),
      ),
    );
  }
}
