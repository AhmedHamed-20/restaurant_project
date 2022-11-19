import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/const/params.dart';

import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/recipes_card_design_widget.dart';
import '../../view_model/bloc/categories_bloc.dart';

class CategoryRecipes extends StatefulWidget {
  const CategoryRecipes(
      {super.key, required this.categoryName, required this.categoriesBloc});
  final String categoryName;
  @override
  State<CategoryRecipes> createState() => _CategoryRecipesState();
  final CategoriesBloc categoriesBloc;
}

class _CategoryRecipesState extends State<CategoryRecipes> {
  @override
  void initState() {
    super.initState();
    widget.categoriesBloc
        .add(CategoryRecipesEvent(categoryName: widget.categoryName));
  }

  @override
  void dispose() async {
    widget.categoriesBloc.add(const ValuesCategoryRecipesResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
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
            body: ListView.builder(
              itemCount:
                  state.categoryRecipesModel!.categoryRecipeDataModel.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutesNames.detailsScreen,
                        arguments: DetailScreenParams(
                            baseRecipesDataModel: state.categoryRecipesModel!
                                .categoryRecipeDataModel[index],
                            amount: 1));
                  },
                  child: RecipesCardWidget(
                    imageCover: state.categoryRecipesModel!
                        .categoryRecipeDataModel[index].imageCover,
                    name: state.categoryRecipesModel!
                        .categoryRecipeDataModel[index].name,
                    price: state.categoryRecipesModel!
                        .categoryRecipeDataModel[index].price,
                  ),
                );
              },
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