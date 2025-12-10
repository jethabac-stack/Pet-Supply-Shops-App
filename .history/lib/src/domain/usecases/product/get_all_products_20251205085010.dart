import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/product_repository.dart';
import '../../entities/product.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return repository.getAllProducts();
  }
}
