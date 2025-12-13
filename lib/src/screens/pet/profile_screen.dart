import 'package:flutter/material.dart';
import 'pet_form_modal.dart';
import 'pet.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<Pet> pets = [
    Pet(
      name: 'Max',
      type: 'Dog',
      breed: 'Labrador',
      birthDate: '2019-06-12',
      weight: 25.5,
      imageUrl: 'https://via.placeholder.com/150/FF6B6B/FFFFFF?text=Max',
    ),
    Pet(
      name: 'Whiskers',
      type: 'Cat',
      breed: 'Persian',
      birthDate: '2020-03-15',
      weight: 4.2,
      imageUrl: 'https://via.placeholder.com/150/4ECDC4/FFFFFF?text=Whiskers',
    ),
    Pet(
      name: 'Buddy',
      type: 'Dog',
      breed: 'Golden Retriever',
      birthDate: '2018-11-22',
      weight: 28.0,
      imageUrl: 'https://via.placeholder.com/150/45B7D1/FFFFFF?text=Buddy',
    ),
  ];

  void _addPet(Pet pet) {
    setState(() {
      pets.add(pet);
    });
  }

  void _editPet(int index, Pet pet) {
    setState(() {
      pets[index] = pet;
    });
  }

  void _showPetForm({Pet? pet, int? index}) {
    showDialog(
      context: context,
      builder: (context) => PetFormModal(
        pet: pet,
        onSave: (newPet) {
          if (index != null) {
            _editPet(index, newPet);
          } else {
            _addPet(newPet);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Profiles'),
        backgroundColor: Colors.teal.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Beloved Pets',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return Hero(
                      tag: 'pet-${pet.name}',
                      child: Card(
                        elevation: 8,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.teal.shade50],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    pet.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.teal.shade100,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.teal.shade100,
                                        child: Icon(
                                          pet.type == 'Dog' ? Icons.pets : Icons.pets,
                                          color: Colors.teal.shade600,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pet.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal.shade800,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${pet.type} • ${pet.breed}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.teal.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.cake,
                                            size: 16,
                                            color: Colors.teal.shade400,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${pet.age} years old',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.teal.shade600,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Icon(
                                            Icons.monitor_weight,
                                            size: 16,
                                            color: Colors.teal.shade400,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${pet.weight} kg',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.teal.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.teal.shade600,
                                  ),
                                  onPressed: () => _showPetForm(pet: pet, index: index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPetForm(),
        backgroundColor: Colors.teal.shade600,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Pet'),
        elevation: 6,
      ),
    );
  }
}
