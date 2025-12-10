import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository repository;

  DeleteCategory(this.repository);

  Future<Either<Failure, void>> call(String categoryId) async {
    return repository.deleteCategory(categoryId);
  }
}
