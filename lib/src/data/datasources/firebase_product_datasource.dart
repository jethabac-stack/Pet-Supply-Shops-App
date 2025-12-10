import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_datasource.dart';
import '../models/product_model.dart';

class FirebaseProductDataSource implements ProductDataSource {
  final FirebaseFirestore _firestore;

  FirebaseProductDataSource([FirebaseFirestore? firestore]) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _products => _firestore.collection('products');

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final snap = await _products.get();
    return snap.docs.map((d) {
      final data = d.data() as Map<String, dynamic>;
      final json = {'id': d.id, ...data};
      return ProductModel.fromJson(json);
    }).toList();
  }

  @override
  Future<ProductModel> getProductById(String productId) async {
    final doc = await _products.doc(productId).get();
    if (!doc.exists) throw Exception('Product not found');
    final data = doc.data() as Map<String, dynamic>;
    final json = {'id': doc.id, ...data};
    return ProductModel.fromJson(json);
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final data = {
      'name': product.name,
      'description': product.description,
      'category': product.category,
      'brand': product.brand,
      'price': product.price,
      'stock': product.stock,
      'imageUrl': product.imageUrl,
      'petTypes': product.petTypes,
      'size': product.size,
    };
    final ref = await _products.add(data);
    final doc = await ref.get();
    final json = {'id': doc.id, ...doc.data() as Map<String, dynamic>};
    return ProductModel.fromJson(json);
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final docRef = _products.doc(product.id);
    final snapshot = await docRef.get();
    if (!snapshot.exists) throw Exception('Product not found');
    await docRef.set({
      'name': product.name,
      'description': product.description,
      'category': product.category,
      'brand': product.brand,
      'price': product.price,
      'stock': product.stock,
      'imageUrl': product.imageUrl,
      'petTypes': product.petTypes,
      'size': product.size,
    });
    final updated = await docRef.get();
    final json = {'id': updated.id, ...updated.data() as Map<String, dynamic>};
    return ProductModel.fromJson(json);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await _products.doc(productId).delete();
  }
}
