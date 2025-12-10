import 'package:equatable/equatable.dart';

class GeneralFailure extends Equatable {
  final String message;

  const GeneralFailure(this.message);

  @override
  List<Object?> get props => [message];
}
