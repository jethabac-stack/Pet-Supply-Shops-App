import '../models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> getUserById(String userId);
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> addUser(UserModel user);
  Future<UserModel> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
}
