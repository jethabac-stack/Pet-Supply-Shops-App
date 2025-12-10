import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/pet_profile.dart';
import '../../domain/usecases/pet_profile/add_pet_profile.dart';
import '../../domain/usecases/pet_profile/update_pet_profile.dart';
import '../../data/datasources/http_pet_profile_datasource.dart';
import '../../data/repositories/pet_profile_repository_impl.dart';

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
  // using HTTP backend instead of Firebase

  String? _userId;
  PetProfile? _editing;
  late AddPetProfile _addPetProfile;
  late UpdatePetProfile _updatePetProfile;
  bool _isLoading = false;
  @override
  void dispose() {
    _nameCtl.dispose();
    _speciesCtl.dispose();
    _ageCtl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    // proceed with HTTP backend

    setState(() => _isLoading = true);

    final profile = PetProfile(
      id: _editing?.id ?? '',
      name: _nameCtl.text.trim(),
      type: _speciesCtl.text.trim(),
      breed: '',
      birthday: null,
    );

    Future.delayed(Duration.zero, () async {
      if (_userId == null || _userId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID is required')));
        setState(() => _isLoading = false);
        return;
      }

      final result = _editing == null
          ? await _addPetProfile(_userId!, profile)
          : await _updatePetProfile(_userId!, profile);

      result.fold((failure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${failure.message}')));
      }, (saved) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
        Navigator.of(context).pop();
      });

      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _userId ??= args['userId'] as String?;
      _editing ??= args['petProfile'] as PetProfile?;
      if (_editing != null && _nameCtl.text.isEmpty) {
        _nameCtl.text = _editing!.name;
        _speciesCtl.text = _editing!.type;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add / Edit Pet Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                initialValue: _userId,
                decoration: const InputDecoration(labelText: 'User ID (owner)'),
                onChanged: (v) => _userId = v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageCtl,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    const baseUrl = 'http://localhost:3000';
    final dataSource = HttpPetProfileDataSource(baseUrl, http.Client());
    final repository = PetProfileRepositoryImpl(dataSource);
    _addPetProfile = AddPetProfile(repository);
    _updatePetProfile = UpdatePetProfile(repository);
  }
}
