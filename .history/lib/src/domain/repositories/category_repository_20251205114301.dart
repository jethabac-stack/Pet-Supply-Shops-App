import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, Category>> getCategoryById(String categoryId);
  Future<Either<Failure, Category>> addCategory(Category category);
  Future<Either<Failure, Category>> updateCategory(Category category);
  Future<Either<Failure, void>> deleteCategory(String categoryId);
}
