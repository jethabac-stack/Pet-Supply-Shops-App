import 'package:cloud_firestore/cloud_firestore.dart';
import 'pet_profile_datasource.dart';
import '../models/pet_profile_model.dart';

class FirebasePetProfileDataSource implements PetProfileDataSource {
  final FirebaseFirestore _firestore;

  FirebasePetProfileDataSource([FirebaseFirestore? firestore]) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference _userPetsRef(String userId) => _firestore.collection('users').doc(userId).collection('pets');

  @override
  Future<List<PetProfileModel>> getPetProfilesForUser(String userId) async {
    final snapshot = await _userPetsRef(userId).get();
    return snapshot.docs.map((d) {
      final data = d.data() as Map<String, dynamic>;
      // normalize birthday if it's a Timestamp
      final b = data['birthday'];
      String? birthdayStr;
      if (b is Timestamp) birthdayStr = b.toDate().toIso8601String();
      else if (b is String) birthdayStr = b;
      final json = {'id': d.id, ...data, 'birthday': birthdayStr};
      return PetProfileModel.fromJson(json);
    }).toList();
  }

  @override
  Future<PetProfileModel> getPetProfileById(String userId, String profileId) async {
    final doc = await _userPetsRef(userId).doc(profileId).get();
    if (!doc.exists) throw Exception('Pet profile not found');
    final data = doc.data() as Map<String, dynamic>;
    final b = data['birthday'];
    String? birthdayStr;
    if (b is Timestamp) birthdayStr = b.toDate().toIso8601String();
    else if (b is String) birthdayStr = b;
    final json = {'id': doc.id, ...data, 'birthday': birthdayStr};
    return PetProfileModel.fromJson(json);
  }

  @override
  Future<PetProfileModel> addPetProfile(String userId, PetProfileModel profile) async {
    final data = {
      'name': profile.name,
      'type': profile.type,
      'breed': profile.breed,
      'birthday': profile.birthday?.toIso8601String(),
    };
    final ref = await _userPetsRef(userId).add(data);
    final doc = await ref.get();
    final map = doc.data() as Map<String, dynamic>;
    final b = map['birthday'];
    String? birthdayStr;
    if (b is Timestamp) birthdayStr = b.toDate().toIso8601String();
    else if (b is String) birthdayStr = b;
    final json = {'id': doc.id, ...map, 'birthday': birthdayStr};
    return PetProfileModel.fromJson(json);
  }

  @override
  Future<PetProfileModel> updatePetProfile(String userId, PetProfileModel profile) async {
    final docRef = _userPetsRef(userId).doc(profile.id);
    final snapshot = await docRef.get();
    if (!snapshot.exists) throw Exception('Pet profile not found');
    await docRef.set({
      'name': profile.name,
      'type': profile.type,
      'breed': profile.breed,
      'birthday': profile.birthday?.toIso8601String(),
    });
    final updated = await docRef.get();
    final map = updated.data() as Map<String, dynamic>;
    final b = map['birthday'];
    String? birthdayStr;
    if (b is Timestamp) birthdayStr = b.toDate().toIso8601String();
    else if (b is String) birthdayStr = b;
    final json = {'id': updated.id, ...map, 'birthday': birthdayStr};
    return PetProfileModel.fromJson(json);
  }

  @override
  Future<void> deletePetProfile(String userId, String profileId) async {
    await _userPetsRef(userId).doc(profileId).delete();
  }
}
