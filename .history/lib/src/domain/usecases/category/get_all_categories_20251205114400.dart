import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/category_repository.dart';
import '../../entities/category.dart';

class GetAllCategories {
  final CategoryRepository repository;

  GetAllCategories(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return repository.getAllCategories();
  }
}
