import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../domain/entities/pet_profile.dart';
import '../../domain/repositories/pet_profile_repository.dart';
import '../datasources/pet_profile_datasource.dart';
import '../models/pet_profile_model.dart';

class PetProfileRepositoryImpl implements PetProfileRepository {
  final PetProfileDataSource _dataSource;

  PetProfileRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<PetProfile>>> getPetProfilesForUser(String userId) async {
    try {
      final models = await _dataSource.getPetProfilesForUser(userId);
      final entities = models.map((model) => model as PetProfile).toList();
      return Right(entities);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PetProfile>> getPetProfileById(String userId, String profileId) async {
    try {
      final model = await _dataSource.getPetProfileById(userId, profileId);
      return Right(model);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PetProfile>> addPetProfile(String userId, PetProfile profile) async {
    try {
      final model = PetProfileModel.fromEntity(profile);
      final result = await _dataSource.addPetProfile(userId, model);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PetProfile>> updatePetProfile(String userId, PetProfile profile) async {
    try {
      final model = PetProfileModel.fromEntity(profile);
      final result = await _dataSource.updatePetProfile(userId, model);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePetProfile(String userId, String profileId) async {
    try {
      await _dataSource.deletePetProfile(userId, profileId);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
