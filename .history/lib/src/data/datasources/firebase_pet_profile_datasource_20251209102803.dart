import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_profile_model.dart';

class FirebasePetProfileDataSource implements PetProfileDataSource {
  final FirebaseFirestore _firestore;

  FirebasePetProfileDataSource(this._firestore);

  @override
  Future<List<PetProfileModel>> getPetProfilesForUser(String userId) async {
    final snapshot = await _firestore.collection('users').doc(userId).collection('petProfiles').get();
    return snapshot.docs.map((doc) => PetProfileModel.fromJson(doc.data())).toList();
  }

  @override
  Future<PetProfileModel> addPetProfile(String userId, PetProfileModel profile) async {
    final docRef = await _firestore.collection('users').doc(userId).collection('petProfiles').add(profile.toJson());
    final doc = await docRef.get();
    return PetProfileModel.fromJson(doc.data()!..['id'] = doc.id);
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
