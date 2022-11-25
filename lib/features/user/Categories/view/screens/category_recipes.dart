import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/const/params.dart';

import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/recipes_card_design_widget.dart';
import '../../view_model/bloc/categories_bloc.dart';
import '../widgets/main_category_recipes_widget.dart';

bool isEndOfCategoryRecipesData = false;
int recipesCategoryPage = 2;

class CategoryRecipes extends StatefulWidget {
  const CategoryRecipes(
      {super.key, required this.categoryName, required this.categoriesBloc});
  final String categoryName;
  final CategoriesBloc categoriesBloc;

  @override
  State<CategoryRecipes> createState() => _CategoryRecipesState();
}

class _CategoryRecipesState extends State<CategoryRecipes> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.categoriesBloc
        .add(CategoryRecipesEvent(categoryName: widget.categoryName));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfCategoryRecipesData == false) {
        widget.categoriesBloc.add(CategoriesRecipesMoreGetEvent(
            categoryName: widget.categoryName,
            page: recipesCategoryPage.toString()));
      }
    });
  }

  @override
  void dispose() async {
    widget.categoriesBloc.add(const ValuesCategoryRecipesResetEvent());
    scrollController.dispose();
    isEndOfCategoryRecipesData = false;
    recipesCategoryPage = 2;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
      isEndOfCategoryRecipesData = state.isEndOfCategoryRecipesData;
    }, builder: (context, state) {
      switch (state.categoryRecipesRequestState) {
        case CategoryRequestStatues.loading:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        case CategoryRequestStatues.success:
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              iconTheme: Theme.of(context).iconTheme,
              elevation: 0,
              backgroundColor: AppColors.transparentColor,
              title: Text(
                widget.categoryName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: MainCategoryRecipesWidget(
              scrollController: scrollController,
            ),
          );
        case CategoryRequestStatues.error:
          return Scaffold(
            body: Center(child: Text(state.errorMessage)),
          );
      }
    });
  }
}
