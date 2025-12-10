import 'package:flutter/material.dart';
import '../../domain/usecases/category/get_all_categories.dart';
import '../../domain/usecases/category/delete_category.dart';
import '../../domain/entities/category.dart';
import '../../providers.dart';

class AdminCategoryListScreen extends StatefulWidget {
  const AdminCategoryListScreen({super.key});

  @override
  State<AdminCategoryListScreen> createState() => _AdminCategoryListScreenState();
}

class _AdminCategoryListScreenState extends State<AdminCategoryListScreen> {
  late final GetAllCategoriesUseCase _getAllCategories;
  late final DeleteCategoryUseCase _deleteCategory;
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final providers = Provider.of(context, listen: false);
    _getAllCategories = providers.getAllCategoriesUseCase;
    _deleteCategory = providers.deleteCategoryUseCase;
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
        content: Text('Are you sure you want to delete "${category.name}"?'),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category deleted')),
          );
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
            onPressed: () => Navigator.pushNamed(context, '/admin/category/form'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _categories.isEmpty
              ? const Center(child: Text('No categories found'))
              : ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (ctx, i) {
                    final category = _categories[i];
                    return ListTile(
                      leading: Text(category.icon),
                      title: Text(category.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/admin/category/form',
                              arguments: category,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteCategoryDialog(category),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
