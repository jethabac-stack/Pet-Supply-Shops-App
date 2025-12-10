import 'package:cloud_firestore/cloud_firestore.dart';
import 'pet_profile_datasource.dart';
import '../models/pet_profile_model.dart';

class FirebasePetProfileDataSource implements PetProfileDataSource {
  final FirebaseFirestore _firestore;

  FirebasePetProfileDataSource(this._firestore);

  @override
  Future<List<PetProfileModel>> getPetProfilesForUser(String userId) async {
    final snapshot = await _firestore.collection('users').doc(userId).collection('petProfiles').get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return PetProfileModel.fromJson(data);
    }).toList();
  }

  @override
  Future<PetProfileModel> getPetProfileById(String userId, String profileId) async {
    final doc = await _firestore.collection('users').doc(userId).collection('petProfiles').doc(profileId).get();
    if (!doc.exists) {
      throw Exception('Pet profile not found');
    }
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return PetProfileModel.fromJson(data);
  }

  @override
  Future<PetProfileModel> addPetProfile(String userId, PetProfileModel profile) async {
    final docRef = await _firestore.collection('users').doc(userId).collection('petProfiles').add(profile.toJson());
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return PetProfileModel.fromJson(data);
  }

  @override
  Future<PetProfileModel> updatePetProfile(String userId, PetProfileModel profile) async {
    await _firestore.collection('users').doc(userId).collection('petProfiles').doc(profile.id).update(profile.toJson());
    return profile;
  }

  @override
  Future<void> deletePetProfile(String userId, String profileId) async {
    await _firestore.collection('users').doc(userId).collection('petProfiles').doc(profileId).delete();
  }
}
