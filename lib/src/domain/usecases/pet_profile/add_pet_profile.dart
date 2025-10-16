import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/pet_profile_repository.dart';
import '../../entities/pet_profile.dart';

class AddPetProfile {
  final PetProfileRepository repository;

  AddPetProfile(this.repository);

  Future<Either<Failure, PetProfile>> call(String userId, PetProfile profile) async {
    return repository.addPetProfile(userId, profile);
  }
}
