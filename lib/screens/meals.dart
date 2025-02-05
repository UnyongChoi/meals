import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Column(children: [
        SizedBox(height: 62),
        Text('No meals found, \nplease check your filters!',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red)),
        SizedBox(height: 32),
        Text('Try selecting different filters.',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: Colors.yellow)),
      ]),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(meal: meals[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
