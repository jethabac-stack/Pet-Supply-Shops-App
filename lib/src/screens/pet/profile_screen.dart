import 'package:flutter/material.dart';

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet Profiles')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const ListTile(title: Text('Max'), subtitle: Text('Dog • Labrador • Born 2019-06-12')),
          ElevatedButton(onPressed: () {}, child: const Text('Add / Edit Pet'))
        ]),
      ),
    );
  }
}
