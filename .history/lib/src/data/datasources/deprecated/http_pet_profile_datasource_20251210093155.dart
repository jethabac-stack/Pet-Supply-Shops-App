import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/datasources/pet_profile_datasource.dart';
import '../models/pet_profile_model.dart';

class HttpPetProfileDataSource implements PetProfileDataSource {
  final String baseUrl;
  final http.Client client;

  HttpPetProfileDataSource(this.baseUrl, this.client);

  @override
  Future<List<PetProfileModel>> getPetProfilesForUser(String userId) async {
    final response = await client.get(Uri.parse('$baseUrl/api/users/$userId/pets'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PetProfileModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pet profiles');
    }
  }

  @override
  Future<PetProfileModel> getPetProfileById(String userId, String profileId) async {
    final response = await client.get(Uri.parse('$baseUrl/api/users/$userId/pets/$profileId'));
    if (response.statusCode == 200) {
      return PetProfileModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Pet profile not found');
    } else {
      throw Exception('Failed to load pet profile');
    }
  }

  @override
  Future<PetProfileModel> addPetProfile(String userId, PetProfileModel profile) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/users/$userId/pets'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profile.toJson()),
    );
    if (response.statusCode == 201) {
      return PetProfileModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add pet profile');
    }
  }

  @override
  Future<PetProfileModel> updatePetProfile(String userId, PetProfileModel profile) async {
    final response = await client.put(
      Uri.parse('$baseUrl/api/users/$userId/pets/${profile.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profile.toJson()),
    );
    if (response.statusCode == 200) {
      return PetProfileModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Pet profile not found');
    } else {
      throw Exception('Failed to update pet profile');
    }
  }

  @override
  Future<void> deletePetProfile(String userId, String profileId) async {
    final response = await client.delete(Uri.parse('$baseUrl/api/users/$userId/pets/$profileId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete pet profile');
    }
  }
}
