import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/usecases/category/get_all_categories.dart';
import '../../domain/usecases/category/delete_category.dart';
import '../../domain/entities/category.dart';
import '../../data/datasources/http_category_datasource.dart';
import '../../data/repositories/category_repository_impl.dart';

class AdminCategoryListScreen extends StatefulWidget {
	const AdminCategoryListScreen({super.key});

	@override
	State<AdminCategoryListScreen> createState() => _AdminCategoryListScreenState();
}

class _AdminCategoryListScreenState extends State<AdminCategoryListScreen> {
	late final GetAllCategories _getAllCategories;
	late final DeleteCategory _deleteCategory;
	List<Category> _categories = [];
	bool _isLoading = true;

	@override
	void initState() {
		super.initState();
		const baseUrl = 'http://localhost:3000';
		final dataSource = HttpCategoryDataSource(baseUrl, http.Client());
		final repository = CategoryRepositoryImpl(dataSource);
		_getAllCategories = GetAllCategories(repository);
		_deleteCategory = DeleteCategory(repository);
		_loadCategories();
	}

	Future<void> _loadCategories() async {
		setState(() => _isLoading = true);
		final result = await _getAllCategories();
		result.fold(
			(failure) => ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text('Error: ${failure.message}')),
			),
			(categories) => setState(() => _categories = categories),
		);
		setState(() => _isLoading = false);
	}

	Future<void> _deleteCategoryDialog(Category category) async {
		final confirmed = await showDialog<bool>(
			context: context,
			builder: (ctx) => AlertDialog(
				title: const Text('Delete Category'),
				content: Text('Delete "${category.name}"?'),
				actions: [
					TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
					TextButton(
						onPressed: () => Navigator.of(ctx).pop(true),
						child: const Text('Delete', style: TextStyle(color: Colors.red)),
					),
				],
			),
		);

		if (confirmed == true) {
			final result = await _deleteCategory(category.id);
			result.fold(
				(failure) => ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text('Error: ${failure.message}')),
				),
				(_) {
					ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Category deleted')));
					_loadCategories();
				},
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Admin - Categories'),
				actions: [
					IconButton(
						icon: const Icon(Icons.add),
						onPressed: () => Navigator.pushNamed(context, '/admin/category/form')
							.then((_) => _loadCategories()),
					),
				],
			),
			body: _isLoading
					? const Center(child: CircularProgressIndicator())
					: _categories.isEmpty
							? Center(
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											const Text('No categories found'),
											const SizedBox(height: 12),
											ElevatedButton(onPressed: _loadCategories, child: const Text('Reload')),
										],
									),
								)
							: ListView.builder(
											itemCount: _categories.length,
											itemBuilder: (ctx, i) {
												final c = _categories[i];
												return ListTile(
													leading: c.icon.isNotEmpty ? Text(c.icon) : null,
													title: Text(c.name),
													trailing: Row(
														mainAxisSize: MainAxisSize.min,
														children: [
															IconButton(
																icon: const Icon(Icons.edit),
																onPressed: () => Navigator.pushNamed(context, '/admin/category/form', arguments: c)
																	.then((_) => _loadCategories()),
															),
															IconButton(
																icon: const Icon(Icons.delete),
																onPressed: () => _deleteCategoryDialog(c),
															),
														],
													),
												);
											},
										),
		);
	}
}
