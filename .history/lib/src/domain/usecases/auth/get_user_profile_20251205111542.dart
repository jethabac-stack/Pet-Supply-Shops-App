import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/auth_repository.dart';
import '../../entities/user.dart';

class GetUserProfile {
  final AuthRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, User>> call(String userId) async {
    final currentUser = await repository.currentUser();
    return currentUser.fold(
      (failure) => Left(failure),
      (user) => user != null ? Right(user) : Left(Failure('User not found')),
    );
  }
}
