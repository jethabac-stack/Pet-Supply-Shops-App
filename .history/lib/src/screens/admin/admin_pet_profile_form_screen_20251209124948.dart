import 'package:flutter/material.dart';

class AdminPetProfileFormScreen extends StatefulWidget {
  const AdminPetProfileFormScreen({super.key});

  @override
  State<AdminPetProfileFormScreen> createState() => _AdminPetProfileFormScreenState();
}

class _AdminPetProfileFormScreenState extends State<AdminPetProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _speciesCtl = TextEditingController();
  final _ageCtl = TextEditingController();
  bool _firebaseAvailable = true;

  @override
  void dispose() {
    _nameCtl.dispose();
    _speciesCtl.dispose();
    _ageCtl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    // For now, just pop with the entered data
    Navigator.of(context).pop({
      'name': _nameCtl.text,
      'species': _speciesCtl.text,
      'age': _ageCtl.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add / Edit Pet Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: !_firebaseAvailable
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Firebase is not configured. Admin features are disabled.'),
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameCtl,
                      decoration: const InputDecoration(labelText: 'Pet name'),
                      validator: (v) => (v ?? '').isEmpty ? 'Enter a name' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _speciesCtl,
                      decoration: const InputDecoration(labelText: 'Species'),
                      validator: (v) => (v ?? '').isEmpty ? 'Enter species' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ageCtl,
                      decoration: const InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
