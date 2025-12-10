import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.role,
  });

  static UserRole _roleFromString(String? s) {
    if (s == null) return UserRole.petOwner;
    return s == 'shopAdmin' ? UserRole.shopAdmin : UserRole.petOwner;
  }

  static String _roleToString(UserRole role) {
    return role == UserRole.shopAdmin ? 'shopAdmin' : 'petOwner';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      role: _roleFromString(json['role'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': _roleToString(role),
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(id: user.id, email: user.email, role: user.role);
  }
}
