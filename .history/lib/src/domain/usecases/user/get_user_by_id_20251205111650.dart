import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/user_repository.dart';
import '../../entities/user.dart';

class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);

  Future<Either<Failure, User>> call(String userId) async {
    return repository.getUserById(userId);
  }
}
