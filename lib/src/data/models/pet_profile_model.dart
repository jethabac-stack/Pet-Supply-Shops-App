import '../../domain/entities/pet_profile.dart';

class PetProfileModel extends PetProfile {
  const PetProfileModel({
    required super.id,
    required super.name,
    required super.type,
    required super.breed,
    super.birthday,
  });

  factory PetProfileModel.fromJson(Map<String, dynamic> json) {
    return PetProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      breed: json['breed'] as String,
      birthday: json['birthday'] != null ? DateTime.parse(json['birthday'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'breed': breed,
      'birthday': birthday?.toIso8601String(),
    };
  }

  factory PetProfileModel.fromEntity(PetProfile petProfile) {
    return PetProfileModel(
      id: petProfile.id,
      name: petProfile.name,
      type: petProfile.type,
      breed: petProfile.breed,
      birthday: petProfile.birthday,
    );
  }
}
