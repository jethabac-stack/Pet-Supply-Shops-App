import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/user_repository.dart';
import '../../entities/user.dart';

class UpdateUserProfile {
  final UserRepository repository;

  UpdateUserProfile(this.repository);

  Future<Either<Failure, User>> call(User user) async {
    return repository.updateUserProfile(user);
  }
}
