import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';

import '../../view_model/bloc/recipes_bloc.dart';
import '../widgets/all_recipes_widget.dart';
import '../widgets/popular_recipes_widget.dart';

int recipesPage = 2;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  bool isEndOfData = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          isEndOfData == false) {
        BlocProvider.of<RecipesBloc>(context).add(
          MoreRecipesGetEvent(
            page: recipesPage.toString(),
          ),
        );
        recipesPage++;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    isEndOfData = false;
    recipesPage = 2;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
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
      ),
    );
  }
}
