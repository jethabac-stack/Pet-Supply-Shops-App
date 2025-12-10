import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        children: const [
          ListTile(title: Text('Products')),
          ListTile(title: Text('Orders')),
          ListTile(title: Text('Customers')),
          ListTile(title: Text('Loyalty Settings')),
        ],
      ),
    );
  }
}
