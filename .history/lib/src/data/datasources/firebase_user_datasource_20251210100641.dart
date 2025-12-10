import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_datasource.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

class FirebaseUserDataSource implements UserDataSource {
  final FirebaseFirestore _firestore;

  FirebaseUserDataSource([FirebaseFirestore? firestore]) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _users => _firestore.collection('users');

  @override
  Future<UserModel> getUserById(String userId) async {
    final doc = await _users.doc(userId).get();
    if (!doc.exists) throw Exception('User not found');
    final data = doc.data() as Map<String, dynamic>;
    final json = {'id': doc.id, ...data};
    return UserModel.fromJson(json);
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    final data = {'email': user.email, 'role': user.role == UserRole.shopAdmin ? 'shopAdmin' : 'petOwner'};
    final ref = await _users.add(data);
    final doc = await ref.get();
    final json = {'id': doc.id, ...doc.data() as Map<String, dynamic>};
    return UserModel.fromJson(json);
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    final docRef = _users.doc(user.id);
    final snapshot = await docRef.get();
    if (!snapshot.exists) throw Exception('User not found');
    await docRef.set({'email': user.email, 'role': user.role == UserRole.shopAdmin ? 'shopAdmin' : 'petOwner'});
    final updated = await docRef.get();
    final json = {'id': updated.id, ...updated.data() as Map<String, dynamic>};
    return UserModel.fromJson(json);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _users.doc(userId).delete();
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final snap = await _users.get();
    return snap.docs.map((d) {
      final data = d.data() as Map<String, dynamic>;
      final json = {'id': d.id, ...data};
      return UserModel.fromJson(json);
    }).toList();
  }
}
