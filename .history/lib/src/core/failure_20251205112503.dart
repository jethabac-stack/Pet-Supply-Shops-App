import 'package:equatable/equatable.dart';

/// Base Failure class for domain errors
abstract class Failure extends Equatable {
  final String message;

  const Failure(super.message);

  @override
  List<Object?> get props => [message];
}

/// Auth-related failures
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// User-related failures
class UserFailure extends Failure {
  const UserFailure(super.message);
}

/// Generic failures
class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

/// Product-related failures
class ProductFailure extends Failure {
  const ProductFailure(super.message);
}
