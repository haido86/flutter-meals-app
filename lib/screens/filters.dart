import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    Widget buildFilterSwitch(
        {required String title,
        required String subtitle,
        required bool value,
        required ValueChanged<bool> onChanged}) {
      return SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        activeColor: Theme.of(context).colorScheme.tertiary,
        contentPadding: const EdgeInsets.only(
          left: 34,
          right: 22,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          buildFilterSwitch(
            title: 'Gluten-free',
            subtitle: 'Only includes gluten-free meals.',
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.glutenFree,
                    isChecked,
                  );
            },
          ),
          buildFilterSwitch(
            title: 'Vegetarian',
            subtitle: 'Only includes vegetarian meals.',
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.vegetarian,
                    isChecked,
                  );
            },
          ),
          buildFilterSwitch(
            title: 'Lactose-free',
            subtitle: 'Only includes lactose-free meals.',
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.lactoseFree,
                    isChecked,
                  );
            },
          ),
          buildFilterSwitch(
            title: 'Vegan',
            subtitle: 'Only includes vegan meals.',
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(
                    Filter.vegan,
                    isChecked,
                  );
            },
          ),
        ],
      ),
    );
  }
}
