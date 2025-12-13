import 'package:flutter/material.dart';

import '../../domain/usecases/category/get_all_categories.dart';
import '../../domain/usecases/category/delete_category.dart';
import '../../domain/entities/category.dart';
import '../../data/datasources/firebase_category_datasource.dart';
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
		final dataSource = FirebaseCategoryDataSource();
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
				backgroundColor: Colors.teal,
				foregroundColor: Colors.white,
				actions: [
					IconButton(
						icon: const Icon(Icons.add),
						tooltip: 'Add Category',
						onPressed: () => Navigator.pushNamed(context, '/admin/category/form')
							.then((_) => _loadCategories()),
					),
				],
			),
			body: Container(
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						colors: [Colors.tealAccent, Colors.white],
						begin: Alignment.topCenter,
						end: Alignment.bottomCenter,
					),
				),
				child: _isLoading
						? const Center(child: CircularProgressIndicator(color: Colors.teal))
						: _categories.isEmpty
								? Center(
										child: Column(
											mainAxisSize: MainAxisSize.min,
											children: [
												Icon(Icons.category_outlined, size: 100, color: Colors.teal.shade200),
												const SizedBox(height: 16),
												const Text(
													'No categories found',
													style: TextStyle(fontSize: 18, color: Colors.teal),
												),
												const SizedBox(height: 16),
												ElevatedButton(
													onPressed: _loadCategories,
													style: ElevatedButton.styleFrom(
														backgroundColor: Colors.teal,
														foregroundColor: Colors.white,
														padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
													),
													child: const Text('Reload'),
												),
											],
										),
									)
								: ListView.builder(
												padding: const EdgeInsets.all(16.0),
												itemCount: _categories.length,
												itemBuilder: (ctx, i) {
													final c = _categories[i];
													return Card(
														elevation: 4,
														margin: const EdgeInsets.only(bottom: 12),
														shape: RoundedRectangleBorder(
															borderRadius: BorderRadius.circular(12),
														),
														child: ListTile(
															leading: CircleAvatar(
																backgroundColor: Colors.teal.shade100,
																child: c.icon.isNotEmpty
																	? Text(c.icon, style: const TextStyle(color: Colors.teal))
																	: const Icon(Icons.category, color: Colors.teal),
															),
															title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold)),
															trailing: Row(
																mainAxisSize: MainAxisSize.min,
																children: [
																	IconButton(
																		icon: const Icon(Icons.edit, color: Colors.teal),
																		tooltip: 'Edit',
																		onPressed: () => Navigator.pushNamed(context, '/admin/category/form', arguments: c)
																			.then((_) => _loadCategories()),
																	),
																	IconButton(
																		icon: const Icon(Icons.delete, color: Colors.red),
																		tooltip: 'Delete',
																		onPressed: () => _deleteCategoryDialog(c),
																	),
																],
															),
															contentPadding: const EdgeInsets.all(16),
														),
													);
												},
											),
			),
		);
	}
}
