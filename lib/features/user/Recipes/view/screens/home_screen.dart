import 'package:flutter/material.dart';
import 'package:resturant/core/const/const.dart';

import '../widgets/all_recipes_widget.dart';
import '../widgets/popular_recipes_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppRadius.r10),
          child: Text(
            'Popular Recipes',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        const PopularRecipesWidget(),
        const SizedBox(
          height: AppHeight.h10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppRadius.r10),
          child: Text(
            'All Recipes',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        const AllRecipesWidget(),
      ],
    );
  }
}
