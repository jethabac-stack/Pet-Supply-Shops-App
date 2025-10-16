import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/pet_profile_repository.dart';
import '../../entities/pet_profile.dart';

class UpdatePetProfile {
  final PetProfileRepository repository;

  UpdatePetProfile(this.repository);

  Future<Either<Failure, PetProfile>> call(String userId, PetProfile profile) async {
    return repository.updatePetProfile(userId, profile);
  }
}
