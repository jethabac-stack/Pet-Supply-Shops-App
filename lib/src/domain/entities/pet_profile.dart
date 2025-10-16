import 'package:equatable/equatable.dart';

class PetProfile extends Equatable {
  final String id;
  final String name;
  final String type; // dog, cat, etc.
  final String breed;
  final DateTime? birthday;

  const PetProfile({required this.id, required this.name, required this.type, required this.breed, this.birthday});

  @override
  List<Object?> get props => [id, name, type, breed, birthday];
}
