import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/auth_repository.dart';
import '../../entities/user.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  Future<Either<Failure, User>> call({required String email, required String password}) async {
    return repository.signInWithEmail(email: email, password: password);
  }
}
