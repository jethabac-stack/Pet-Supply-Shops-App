// Deprecated HTTP datasource — the app now uses Firestore via FirebaseCategoryDataSource.
// This stub keeps the file present for history but prevents accidental runtime HTTP calls.
import 'category_datasource.dart';
import '../models/category_model.dart';

class HttpCategoryDataSource implements CategoryDataSource {
  HttpCategoryDataSource([String? baseUrl, dynamic client]);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    throw UnimplementedError('HttpCategoryDataSource is deprecated. Use FirebaseCategoryDataSource instead.');
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    throw UnimplementedError('HttpCategoryDataSource is deprecated. Use FirebaseCategoryDataSource instead.');
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    throw UnimplementedError('HttpCategoryDataSource is deprecated. Use FirebaseCategoryDataSource instead.');
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    throw UnimplementedError('HttpCategoryDataSource is deprecated. Use FirebaseCategoryDataSource instead.');
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    throw UnimplementedError('HttpCategoryDataSource is deprecated. Use FirebaseCategoryDataSource instead.');
  }
}
