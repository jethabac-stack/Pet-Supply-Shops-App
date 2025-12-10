import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    try {
      final model = await _dataSource.getUserById(userId);
      return Right(model);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final list = await _dataSource.getAllUsers();
      final entities = list.map((m) => m as User).toList();
      return Right(entities);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile(User user) async {
    try {
      final model = UserModel.fromEntity(user);
      final result = await _dataSource.updateUser(model);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await _dataSource.deleteUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
