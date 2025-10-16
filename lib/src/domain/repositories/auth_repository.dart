import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmail({required String email, required String password, required UserRole role});
  Future<Either<Failure, User>> signInWithEmail({required String email, required String password});
  Future<Either<Failure, User>> signInWithFirebaseCredential({required String idToken});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User?>> currentUser();
}
