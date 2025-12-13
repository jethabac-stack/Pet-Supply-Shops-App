import 'package:flutter/material.dart';
import 'pet.dart';

class PetFormModal extends StatefulWidget {
  final Pet? pet;
  final Function(Pet) onSave;

  const PetFormModal({super.key, this.pet, required this.onSave});

  @override
  _PetFormModalState createState() => _PetFormModalState();
}

class _PetFormModalState extends State<PetFormModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _breedController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _weightController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pet != null) {
      _nameController.text = widget.pet!.name;
      _typeController.text = widget.pet!.type;
      _breedController.text = widget.pet!.breed;
      _birthDateController.text = widget.pet!.birthDate;
      _weightController.text = widget.pet!.weight.toString();
      _imageUrlController.text = widget.pet!.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _breedController.dispose();
    _birthDateController.dispose();
    _weightController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _savePet() {
    if (_formKey.currentState!.validate()) {
      final pet = Pet(
        name: _nameController.text,
        type: _typeController.text,
        breed: _breedController.text,
        birthDate: _birthDateController.text,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        imageUrl: _imageUrlController.text,
      );
      widget.onSave(pet);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.pet == null ? 'Add New Pet' : 'Edit Pet'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type (e.g., Dog, Cat)'),
                validator: (value) => value!.isEmpty ? 'Please enter a type' : null,
              ),
              TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(labelText: 'Breed'),
                validator: (value) => value!.isEmpty ? 'Please enter a breed' : null,
              ),
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(labelText: 'Birth Date (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Please enter a birth date' : null,
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter weight' : null,
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _savePet,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
