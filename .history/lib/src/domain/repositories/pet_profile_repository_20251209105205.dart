import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/pet_profile.dart';

abstract class PetProfileRepository {
  Future<Either<Failure, List<PetProfile>>> getPetProfilesForUser(String userId);
  Future<Either<Failure, PetProfile>> getPetProfileById(String userId, String profileId);
  Future<Either<Failure, PetProfile>> addPetProfile(String userId, PetProfile profile);
  Future<Either<Failure, PetProfile>> updatePetProfile(String userId, PetProfile profile);
  Future<Either<Failure, void>> deletePetProfile(String userId, String profileId);
}
