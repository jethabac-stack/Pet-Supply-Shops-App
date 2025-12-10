import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, void>> call(String userId) async {
    return repository.deleteUser(userId);
  }
}
