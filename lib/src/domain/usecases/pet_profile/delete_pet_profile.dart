import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/pet_profile_repository.dart';

class DeletePetProfile {
  final PetProfileRepository repository;

  DeletePetProfile(this.repository);

  Future<Either<Failure, void>> call(String userId, String profileId) async {
    return repository.deletePetProfile(userId, profileId);
  }
}
