import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/category_repository.dart';
import '../../entities/category.dart';

class AddCategory {
  final CategoryRepository repository;

  AddCategory(this.repository);

  Future<Either<Failure, Category>> call(Category category) async {
    return repository.addCategory(category);
  }
}
