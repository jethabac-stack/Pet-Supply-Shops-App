import 'package:cloud_firestore/cloud_firestore.dart';
import 'category_datasource.dart';
import '../models/category_model.dart';

class FirebaseCategoryDataSource implements CategoryDataSource {
  final FirebaseFirestore _firestore;

  FirebaseCategoryDataSource([FirebaseFirestore? firestore]) : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _categories => _firestore.collection('categories');

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _categories.get();
    return snapshot.docs.map((d) {
      final data = d.data() as Map<String, dynamic>;
      final json = {'id': d.id, ...data};
      return CategoryModel.fromJson(json);
    }).toList();
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    final doc = await _categories.doc(categoryId).get();
    if (!doc.exists) throw Exception('Category not found');
    final data = doc.data() as Map<String, dynamic>;
    final json = {'id': doc.id, ...data};
    return CategoryModel.fromJson(json);
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    final data = {'name': category.name, 'icon': category.icon};
    final ref = await _categories.add(data);
    final doc = await ref.get();
    final json = {'id': doc.id, ...doc.data() as Map<String, dynamic>};
    return CategoryModel.fromJson(json);
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    final docRef = _categories.doc(category.id);
    final snapshot = await docRef.get();
    if (!snapshot.exists) throw Exception('Category not found');
    await docRef.set({'name': category.name, 'icon': category.icon});
    final updated = await docRef.get();
    final json = {'id': updated.id, ...updated.data() as Map<String, dynamic>};
    return CategoryModel.fromJson(json);
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await _categories.doc(categoryId).delete();
  }
}
