import 'package:flutter/material.dart';
import '../models/meal.dart';

class AddMealScreen extends StatefulWidget {
  final Function(Meal) onAddMeal;

  const AddMealScreen({super.key, required this.onAddMeal});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();

  void _submit() {
    final name = _nameController.text;
    final calories = int.tryParse(_caloriesController.text) ?? 0;
    final protein = int.tryParse(_proteinController.text) ?? 0;

    if (name.isNotEmpty && calories > 0) {
      final meal = Meal(
        name: name,
        calories: calories,
        protein: protein,
        dateTime: DateTime.now(),
      );
      widget.onAddMeal(meal);
      
      // Clear fields and show confirmation
      _nameController.clear();
      _caloriesController.clear();
      _proteinController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Meal Added Successfully! 🥗'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Add a Meal", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildTextField(_nameController, "Meal Name", Icons.fastfood),
            const SizedBox(height: 15),
            _buildTextField(_caloriesController, "Calories (kcal)", Icons.local_fire_department, isNumber: true),
            const SizedBox(height: 15),
            _buildTextField(_proteinController, "Protein (g)", Icons.fitness_center, isNumber: true),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: _submit,
                child: const Text("Save Meal", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.green),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.green), borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[900],
      ),
    );
  }
}