import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/pet_profile_repository.dart';
import '../../entities/pet_profile.dart';

class GetPetProfiles {
  final PetProfileRepository repository;

  GetPetProfiles(this.repository);

  Future<Either<Failure, List<PetProfile>>> call(String userId) async {
    return repository.getPetProfilesForUser(userId);
  }
}
