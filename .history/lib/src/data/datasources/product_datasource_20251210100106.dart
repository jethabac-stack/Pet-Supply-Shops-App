import '../models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String productId);
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
}
