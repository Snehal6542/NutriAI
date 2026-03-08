import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'home_screen.dart';
import 'add_meal_screen.dart';
import 'summary_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  // State lifted up to MainScreen so all tabs can access the same data
  final List<Meal> _meals = [];

  void _addMeal(Meal meal) {
    setState(() {
      _meals.add(meal);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(meals: _meals),
      AddMealScreen(onAddMeal: _addMeal),
      SummaryScreen(meals: _meals),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Add Meal'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Summary'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}