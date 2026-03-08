import 'package:flutter/material.dart';
import '../models/meal.dart';

class HomeScreen extends StatelessWidget {
  final List<Meal> meals;
  const HomeScreen({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Good Morning, Rahul 👋", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: meals.isEmpty
          ? const Center(child: Text("No meals added today.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.restaurant, color: Colors.white)),
                    title: Text(meal.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text("${meal.calories} kcal | ${meal.protein}g protein", style: const TextStyle(color: Colors.grey)),
                    trailing: Text("${meal.dateTime.hour}:${meal.dateTime.minute.toString().padLeft(2, '0')}", style: const TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
    );
  }
}