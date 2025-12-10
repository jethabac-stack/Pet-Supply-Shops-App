import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/product_repository.dart';
import '../../entities/product.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> call(String productId) async {
    return repository.getProductById(productId);
  }
}
