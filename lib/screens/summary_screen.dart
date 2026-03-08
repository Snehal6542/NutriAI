import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/meal.dart';
import '../services/ai_service.dart';

class SummaryScreen extends StatelessWidget {
  final List<Meal> meals;
  const SummaryScreen({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    int requiredCalories = 2000;
    int requiredProtein = 120;
    
    int totalCalories = meals.fold(0, (sum, meal) => sum + meal.calories);
    int totalProtein = meals.fold(0, (sum, meal) => sum + meal.protein);
    
    double caloriePercent = (totalCalories / requiredCalories).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Daily Summary 📊", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: caloriePercent,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$totalCalories / $requiredCalories", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                  const Text("kcal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.grey)),
                ],
              ),
              footer: const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Calories Consumed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white)),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.green,
              backgroundColor: Colors.grey[800]!,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Text("Protein: $totalProtein g / $requiredProtein g", style: const TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(
                    ProteinAIService.getProteinSuggestion(totalProtein, requiredProtein),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}