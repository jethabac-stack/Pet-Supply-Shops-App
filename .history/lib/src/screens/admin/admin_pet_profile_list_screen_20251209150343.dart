import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/usecases/pet_profile/get_pet_profiles.dart';
import '../../domain/usecases/pet_profile/delete_pet_profile.dart';
import '../../domain/entities/pet_profile.dart';
import '../../data/datasources/http_pet_profile_datasource.dart';
import '../../data/repositories/pet_profile_repository_impl.dart';

class AdminPetProfileListScreen extends StatefulWidget {
  const AdminPetProfileListScreen({super.key});

  @override
  State<AdminPetProfileListScreen> createState() => _AdminPetProfileListScreenState();
}

class _AdminPetProfileListScreenState extends State<AdminPetProfileListScreen> {
  late final GetPetProfiles _getPetProfiles;
  late final DeletePetProfile _deletePetProfile;
  List<PetProfile> _petProfiles = [];
  bool _isLoading = true;
  String _selectedUserId = ''; // For simplicity, assume we have a way to select user

  @override
  void initState() {
    super.initState();
    const baseUrl = 'http://localhost:3000';
    final dataSource = HttpPetProfileDataSource(baseUrl, http.Client());
    final repository = PetProfileRepositoryImpl(dataSource);
    _getPetProfiles = GetPetProfiles(repository);
    _deletePetProfile = DeletePetProfile(repository);
    // Do not auto-load until user enters userId
    setState(() => _isLoading = false);
  }

  Future<void> _loadPetProfiles() async {
    if (_selectedUserId.isEmpty) return; // Need user ID

    setState(() => _isLoading = true);
    final result = await _getPetProfiles(_selectedUserId);
    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${failure.message}')),
      ),
      (petProfiles) => setState(() => _petProfiles = petProfiles),
    );
    setState(() => _isLoading = false);
  }

  Future<void> _deletePetProfileDialog(PetProfile petProfile) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Pet Profile'),
        content: Text('Are you sure you want to delete "${petProfile.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final result = await _deletePetProfile(_selectedUserId, petProfile.id);
      result.fold(
        (failure) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${failure.message}')),
        ),
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pet profile deleted')),
          );
          _loadPetProfiles();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Pet Profiles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_selectedUserId.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a User ID first')));
                return;
              }
              Navigator.pushNamed(context, '/admin/pet-profile/form', arguments: {'userId': _selectedUserId});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _selectedUserId = value,
              onSubmitted: (_) => _loadPetProfiles(),
            ),
          ),
          ElevatedButton(
            onPressed: _loadPetProfiles,
            child: const Text('Load Pet Profiles'),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _petProfiles.isEmpty
                    ? const Center(child: Text('No pet profiles found'))
                    : ListView.builder(
                        itemCount: _petProfiles.length,
                        itemBuilder: (ctx, i) {
                          final petProfile = _petProfiles[i];
                          return ListTile(
                            title: Text(petProfile.name),
                            subtitle: Text('${petProfile.type} - ${petProfile.breed}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    '/admin/pet-profile/form',
                                    arguments: {'userId': _selectedUserId, 'petProfile': petProfile},
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deletePetProfileDialog(petProfile),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../domain/usecases/pet_profile/get_pet_profiles.dart';
import '../../domain/usecases/pet_profile/delete_pet_profile.dart';
import '../../domain/entities/pet_profile.dart';
import '../../data/datasources/firebase_pet_profile_datasource.dart';
import '../../data/repositories/pet_profile_repository_impl.dart';
=======
import 'package:flutter/material.dart';
import '../../domain/usecases/pet_profile/get_pet_profiles.dart';
import '../../domain/usecases/pet_profile/delete_pet_profile.dart';
import '../../domain/entities/pet_profile.dart';
import '../../data/repositories/pet_profile_repository_impl.dart';
