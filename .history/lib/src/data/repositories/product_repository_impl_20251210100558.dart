import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_datasource.dart';
import '../datasources/category_datasource.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _productDataSource;
  final CategoryDataSource _categoryDataSource;

  ProductRepositoryImpl(this._productDataSource, this._categoryDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final models = await _productDataSource.getAllProducts();
      final entities = models.map((m) => m as Product).toList();
      return Right(entities);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId) async {
    try {
      final all = await _productDataSource.getAllProducts();
      final filtered = all.where((m) => m.category == categoryId).map((m) => m as Product).toList();
      return Right(filtered);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String productId) async {
    try {
      final model = await _productDataSource.getProductById(productId);
      return Right(model);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final all = await _productDataSource.getAllProducts();
      final filtered = all.where((m) => m.name.toLowerCase().contains(query.toLowerCase())).map((m) => m as Product).toList();
      return Right(filtered);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> filterProducts({String? brand, String? petType, String? size}) async {
    try {
      final all = await _productDataSource.getAllProducts();
      final filtered = all.where((m) {
        var ok = true;
        if (brand != null && brand.isNotEmpty) ok = ok && m.brand == brand;
        if (petType != null && petType.isNotEmpty) ok = ok && m.petTypes.contains(petType);
        if (size != null && size.isNotEmpty) ok = ok && (m.size == size);
        return ok;
      }).map((m) => m as Product).toList();
      return Right(filtered);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final models = await _categoryDataSource.getAllCategories();
      final entities = models.map((m) => m as Category).toList();
      return Right(entities);
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
