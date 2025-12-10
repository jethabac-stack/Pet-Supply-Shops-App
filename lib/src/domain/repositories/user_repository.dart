import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserById(String userId);
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, User>> updateUserProfile(User user);
  Future<Either<Failure, void>> deleteUser(String userId);
}
