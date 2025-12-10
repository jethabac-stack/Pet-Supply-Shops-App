import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_datasource.dart';
import '../models/category_model.dart';

class HttpCategoryDataSource implements CategoryDataSource {
  final String baseUrl;
  final http.Client client;

  HttpCategoryDataSource(this.baseUrl, this.client);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await client.get(Uri.parse('$baseUrl/api/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    final response = await client.get(Uri.parse('$baseUrl/api/categories/$categoryId'));
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Category not found');
    } else {
      throw Exception('Failed to load category');
    }
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/categories'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toJson()),
    );
    if (response.statusCode == 201) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add category');
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    final response = await client.put(
      Uri.parse('$baseUrl/api/categories/${category.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(category.toJson()),
    );
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Category not found');
    } else {
      throw Exception('Failed to update category');
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final response = await client.delete(Uri.parse('$baseUrl/api/categories/$categoryId'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete category');
    }
  }
}
