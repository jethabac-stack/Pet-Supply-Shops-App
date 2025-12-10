import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/product_repository.dart';
import '../../entities/product.dart';

class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, List<Product>>> call(String categoryId) async {
    return repository.getProductsByCategory(categoryId);
  }
}
