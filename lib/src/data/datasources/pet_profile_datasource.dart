import '../models/pet_profile_model.dart';

abstract class PetProfileDataSource {
  Future<List<PetProfileModel>> getPetProfilesForUser(String userId);
  Future<PetProfileModel> getPetProfileById(String userId, String profileId);
  Future<PetProfileModel> addPetProfile(String userId, PetProfileModel profile);
  Future<PetProfileModel> updatePetProfile(String userId, PetProfileModel profile);
  Future<void> deletePetProfile(String userId, String profileId);
}
