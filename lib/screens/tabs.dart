import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/categories.dart';
import 'package:meal/screens/meals.dart';
import 'package:meal/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisiting = _favoriteMeals.contains(meal);
    setState(() {
      ScaffoldMessenger.of(context).clearSnackBars();
      if (isExisiting) {
        _favoriteMeals.remove(meal);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Removed from favorite!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        _favoriteMeals.add(meal);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('added favorite!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void setSelectedPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      toggleFavorite: _toggleMealFavoriteStatus,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        toggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorite';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDraw(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: setSelectedPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
