import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        children: [
          ListTile(title: const Text('Products')),
          ListTile(title: const Text('Orders')),
          ListTile(title: const Text('Customers')),
          ListTile(title: const Text('Loyalty Settings')),
        ],
      ),
    );
  }
}
