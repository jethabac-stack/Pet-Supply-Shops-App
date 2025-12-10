import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_datasource.dart';
import '../models/category_model.dart';

class FirebaseCategoryDataSource implements CategoryDataSource {
  final FirebaseFirestore _firestore;

  FirebaseCategoryDataSource(this._firestore);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList();
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    final doc = await _firestore.collection('categories').doc(categoryId).get();
    if (!doc.exists) {
      throw Exception('Category not found');
    }
    return CategoryModel.fromJson(doc.data()!);
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    final docRef = await _firestore.collection('categories').add(category.toJson());
    final doc = await docRef.get();
    return CategoryModel.fromJson(doc.data()!..['id'] = doc.id);
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    await _firestore.collection('categories').doc(category.id).update(category.toJson());
    return category;
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }
}
