import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders & Subscriptions')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(title: const Text('Dog Food - every 30 days'), trailing: ElevatedButton(onPressed: () {}, child: const Text('Edit'))),
          const SizedBox(height: 12),
          ListTile(title: const Text('Auto-Reorder: Off'), trailing: OutlinedButton(onPressed: () {}, child: const Text('Enable'))),
        ],
      ),
    );
  }
}
