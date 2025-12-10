import 'package:equatable/equatable.dart';

/// Base Failure class for domain errors
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Auth-related failures
class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

/// User-related failures
class UserFailure extends Failure {
  const UserFailure(String message) : super(message);
}

/// Generic failures
class GeneralFailure extends Failure {
  const GeneralFailure(String message) : super(message);
}

/// Product-related failures
class ProductFailure extends Failure {
  const ProductFailure(String message) : super(message);
}
