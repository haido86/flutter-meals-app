import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/data/dummy_data.dart';

enum Filter {
  glutenFree,
  vegetarian,
  lactoseFree,
  vegan,
}

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.vegetarian: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
};

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(kInitialFilter);

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filterMealsProvider = Provider((ref) {
  final activeFilters = ref.watch(filtersProvider);
  return dummyMeals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
