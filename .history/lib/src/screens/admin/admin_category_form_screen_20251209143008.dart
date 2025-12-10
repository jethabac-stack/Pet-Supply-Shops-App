import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../domain/usecases/category/add_category.dart';
import '../../domain/usecases/category/update_category.dart';
import '../../domain/entities/category.dart';
import '../../data/datasources/firebase_category_datasource.dart';
import '../../data/repositories/category_repository_impl.dart';

class AdminCategoryFormScreen extends StatefulWidget {
  const AdminCategoryFormScreen({super.key});

  @override
  State<AdminCategoryFormScreen> createState() => _AdminCategoryFormScreenState();
}

class _AdminCategoryFormScreenState extends State<AdminCategoryFormScreen> {
  late final AddCategory _addCategory;
  late final UpdateCategory _updateCategory;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _iconController = TextEditingController();
  Category? _editingCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    const baseUrl = 'http://localhost:3000/api';
    final repository = CategoryRepositoryImpl(baseUrl);
    _addCategory = AddCategory(repository);
    _updateCategory = UpdateCategory(repository);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Category) {
        _editingCategory = args;
        _nameController.text = args.name;
        _iconController.text = args.icon;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final category = Category(
      id: _editingCategory?.id ?? '',
      name: _nameController.text.trim(),
      icon: _iconController.text.trim(),
    );

    final result = _editingCategory == null
        ? await _addCategory(category)
        : await _updateCategory(category);

    result.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${failure.message}')),
      ),
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_editingCategory == null ? 'Category added' : 'Category updated')),
        );
        Navigator.of(context).pop();
      },
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingCategory == null ? 'Add Category' : 'Edit Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _iconController,
                decoration: const InputDecoration(
                  labelText: 'Icon (emoji or text)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an icon';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveCategory,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(_editingCategory == null ? 'Add Category' : 'Update Category'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
