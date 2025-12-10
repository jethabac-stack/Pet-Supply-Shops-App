import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/product.dart';
import '../entities/category.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId);
  Future<Either<Failure, Product>> getProductById(String productId);
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, List<Product>>> filterProducts({
    String? brand,
    String? petType,
    String? size,
  });
  Future<Either<Failure, List<Category>>> getAllCategories();
}
