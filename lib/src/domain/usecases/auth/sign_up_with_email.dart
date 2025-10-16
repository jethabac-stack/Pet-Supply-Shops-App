import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/auth_repository.dart';
import '../../entities/user.dart';

class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  Future<Either<Failure, User>> call({required String email, required String password, required UserRole role}) async {
    return repository.signUpWithEmail(email: email, password: password, role: role);
  }
}
