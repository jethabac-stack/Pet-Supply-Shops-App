import 'package:flutter/material.dart';
import '../domain/entities/product.dart';
import '../providers.dart';
import 'product_form_modal.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  List<Product> _mockProducts() => [
        Product(
          id: 'p1',
          name: 'Dog Food - 5kg',
          description: 'High quality dog food',
          category: 'Food',
          brand: 'GoodPet',
          price: 1999.0,
          stock: 12,
          imageUrl: '',
          petTypes: ['dog'],
        ),
        Product(
          id: 'p2',
          name: 'Cat Treats - Tuna',
          description: 'Tasty tuna treats for cats',
          category: 'Treats',
          brand: 'Yummy',
          price: 149.0,
          stock: 34,
          imageUrl: '',
          petTypes: ['cat'],
        ),
        Product(
          id: 'p3',
          name: 'Shampoo - All Pets',
          description: 'Gentle shampoo suitable for all pets',
          category: 'Grooming',
          brand: 'CleanCo',
          price: 299.0,
          stock: 5,
          imageUrl: '',
          petTypes: ['dog', 'cat'],
        ),
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
            tooltip: 'View Cart',
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
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, i) {
            final p = products[i];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/product', arguments: {'id': p.id}),
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image Placeholder
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          p.category == 'Food' ? Icons.restaurant : p.category == 'Treats' ? Icons.cake : Icons.cleaning_services,
                          size: 48,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${p.brand} • ${p.category}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₱${p.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cart.add(p);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Added ${p.name} to cart'),
                                      backgroundColor: Colors.teal,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add_shopping_cart, size: 20),
                                color: Colors.teal,
                                tooltip: 'Add to Cart',
                              ),
                            ],
                          ),
                          // Stock indicator
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: p.stock > 10 ? Colors.green.shade100 : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Stock: ${p.stock}',
                              style: TextStyle(
                                fontSize: 10,
                                color: p.stock > 10 ? Colors.green.shade800 : Colors.orange.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pets, size: 48, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'Pet Supplies',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.pets, color: Colors.white),
                title: const Text('Pet Profile', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/pet-profile'),
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.white),
                title: const Text('Reminders', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pushNamed(context, '/reminders'),
              ),
              const Divider(color: Colors.white54),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => ProductFormModal(
              onSave: (product) {
                // In a real app, save to backend
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product "${product.name}" saved'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        tooltip: 'Add Product',
      ),
    );
  }
}
