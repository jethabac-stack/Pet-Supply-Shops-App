// Deprecated HTTP pet profile datasource — use Firestore via FirebasePetProfileDataSource.
// This stub prevents accidental HTTP calls while preserving the file for history.
import 'pet_profile_datasource.dart';
import '../models/pet_profile_model.dart';

class HttpPetProfileDataSource implements PetProfileDataSource {
  HttpPetProfileDataSource([String? baseUrl, dynamic client]);

  @override
  Future<List<PetProfileModel>> getPetProfilesForUser(String userId) async {
    throw UnimplementedError('HttpPetProfileDataSource is deprecated. Use FirebasePetProfileDataSource instead.');
  }

  @override
  Future<PetProfileModel> getPetProfileById(String userId, String profileId) async {
    throw UnimplementedError('HttpPetProfileDataSource is deprecated. Use FirebasePetProfileDataSource instead.');
  }

  @override
  Future<PetProfileModel> addPetProfile(String userId, PetProfileModel profile) async {
    throw UnimplementedError('HttpPetProfileDataSource is deprecated. Use FirebasePetProfileDataSource instead.');
  }

  @override
  Future<PetProfileModel> updatePetProfile(String userId, PetProfileModel profile) async {
    throw UnimplementedError('HttpPetProfileDataSource is deprecated. Use FirebasePetProfileDataSource instead.');
  }

  @override
  Future<void> deletePetProfile(String userId, String profileId) async {
    throw UnimplementedError('HttpPetProfileDataSource is deprecated. Use FirebasePetProfileDataSource instead.');
  }
}
