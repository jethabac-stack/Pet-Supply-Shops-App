import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.inventory, color: Colors.teal),
                title: const Text('Products', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Manage product catalog'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {},
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.teal),
                title: const Text('Orders', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('View and manage orders'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {},
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.people, color: Colors.teal),
                title: const Text('Customers', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Customer management'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {},
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.loyalty, color: Colors.teal),
                title: const Text('Loyalty Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Configure loyalty program'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                onTap: () {},
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
