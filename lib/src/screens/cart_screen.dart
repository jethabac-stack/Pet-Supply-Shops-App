import 'package:flutter/material.dart';
import '../providers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final cart = CartServiceProvider.of(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, i) => ListTile(title: Text(items[i].name), trailing: Text('₱${items[i].price.toStringAsFixed(0)}')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total: ₱${cart.total.toStringAsFixed(2)}'), ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed (mock)'))); cart.clear(); Navigator.pop(context); }, child: const Text('Checkout'))]),
                )
              ],
            ),
    );
  }
}
