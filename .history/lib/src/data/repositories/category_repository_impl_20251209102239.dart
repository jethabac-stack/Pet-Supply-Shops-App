import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final models = await _dataSource.getAllCategories();
      final entities = models.map((model) => model as Category).toList();
      return Right(entities);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String categoryId) async {
    try {
      final model = await _dataSource.getCategoryById(categoryId);
      return Right(model);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> addCategory(Category category) async {
    try {
      final model = CategoryModel.fromEntity(category);
      final result = await _dataSource.addCategory(model);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> updateCategory(Category category) async {
    try {
      final model = CategoryModel.fromEntity(category);
      final result = await _dataSource.updateCategory(model);
      return Right(result);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String categoryId) async {
    try {
      await _dataSource.deleteCategory(categoryId);
      return const Right(null);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
