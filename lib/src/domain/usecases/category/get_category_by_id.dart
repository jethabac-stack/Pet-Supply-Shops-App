import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/category_repository.dart';
import '../../entities/category.dart';

class GetCategoryById {
  final CategoryRepository repository;

  GetCategoryById(this.repository);

  Future<Either<Failure, Category>> call(String categoryId) async {
    return repository.getCategoryById(categoryId);
  }
}
