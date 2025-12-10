import 'package:dartz/dartz.dart';
import '../../../core/failure.dart';
import '../../repositories/product_repository.dart';
import '../../entities/product.dart';

class FilterProducts {
  final ProductRepository repository;

  FilterProducts(this.repository);

  Future<Either<Failure, List<Product>>> call({
    String? brand,
    String? petType,
    String? size,
  }) async {
    return repository.filterProducts(brand: brand, petType: petType, size: size);
  }
}
