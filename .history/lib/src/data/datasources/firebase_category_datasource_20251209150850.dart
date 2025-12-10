// Firebase datasource removed. Use `HttpCategoryDataSource` (HTTP -> Node.js API)
// This file is kept as a placeholder for compatibility. The app now uses HTTP datasources.
import 'category_datasource.dart';
import '../models/category_model.dart';

class FirebaseCategoryDataSource implements CategoryDataSource {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    throw UnimplementedError('FirebaseCategoryDataSource removed. Use HttpCategoryDataSource instead.');
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    throw UnimplementedError('FirebaseCategoryDataSource removed. Use HttpCategoryDataSource instead.');
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    throw UnimplementedError('FirebaseCategoryDataSource removed. Use HttpCategoryDataSource instead.');
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    throw UnimplementedError('FirebaseCategoryDataSource removed. Use HttpCategoryDataSource instead.');
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    throw UnimplementedError('FirebaseCategoryDataSource removed. Use HttpCategoryDataSource instead.');
  }
}
