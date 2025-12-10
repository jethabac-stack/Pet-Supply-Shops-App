import '../../core/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource _dataSource;

  CategoryRepositoryImpl(this._dataSource);
=======
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../core/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/http_category_datasource.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final HttpCategoryDataSource _dataSource;

  CategoryRepositoryImpl(String baseUrl)
      : _dataSource = HttpCategoryDataSource(baseUrl, http.Client());
