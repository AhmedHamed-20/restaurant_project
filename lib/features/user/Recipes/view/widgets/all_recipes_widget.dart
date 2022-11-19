import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/params.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/recipes_card_design_widget.dart';
import '../../view_model/bloc/recipes_bloc.dart';

class AllRecipesWidget extends StatelessWidget {
  const AllRecipesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipesBloc, RecipesState>(
      builder: (context, state) {
        switch (state.recipeRequestStatues) {
          case RecipeRequestStatues.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RecipeRequestStatues.success:
            return Expanded(
              child: ListView.builder(
                  itemCount: state.recipesModel!.recipeDataModel.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutesNames.detailsScreen,
                          arguments: state.recipesModel!.recipeDataModel[index],
                        );
                      },
                      child: RecipesCardWidget(
                          imageCover: state
                              .recipesModel!.recipeDataModel[index].imageCover,
                          name: state.recipesModel!.recipeDataModel[index].name,
                          price:
                              state.recipesModel!.recipeDataModel[index].price),
                    );
                  }),
            );
          case RecipeRequestStatues.error:
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
        }
      },
    );
  }
}
