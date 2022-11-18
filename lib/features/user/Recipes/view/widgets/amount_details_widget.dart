import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/user/Recipes/models/recipe_data_model.dart';

import '../../../../../core/const/const.dart';
import '../../models/favourite_model.dart';
import '../../view_model/bloc/recipes_bloc.dart';

class AmountDetailsWidget extends StatelessWidget {
  const AmountDetailsWidget({
    Key? key,
    required this.recipeDataModel,
    required this.userId,
  }) : super(key: key);
  final RecipeDataModel recipeDataModel;
  final String userId;
  @override
  Widget build(BuildContext context) {
    var recipesBloc = BlocProvider.of<RecipesBloc>(context);
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              recipesBloc.add(ChangeAmountRecipesEvent(
                  recipeId: recipeDataModel.id, isAdd: false));
            },
            icon: const Icon(
              Icons.remove,
            ),
          ),
          BlocBuilder<RecipesBloc, RecipesState>(
            builder: (context, state) {
              return Text(
                state.amount![recipeDataModel.id].toString(),
                style: Theme.of(context).textTheme.titleMedium,
              );
            },
          ),
          IconButton(
            onPressed: () {
              recipesBloc.add(ChangeAmountRecipesEvent(
                  recipeId: recipeDataModel.id, isAdd: true));
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(
            width: AppWidth.w10,
          ),
          IconButton(
            onPressed: () {
              recipesBloc.add(
                FavouriteAddToDataBaseEvent(
                  favouriteModel: FavouriteModel(
                    category: recipeDataModel.category,
                    recipeId: recipeDataModel.id,
                    imageCover: recipeDataModel.imageCover,
                    name: recipeDataModel.name,
                    cookingTime: recipeDataModel.cookingTime,
                    databaseId: 0,
                    ingredients: recipeDataModel.ingredients,
                    price: recipeDataModel.price,
                    slug: recipeDataModel.slug,
                  ),
                  tableName: 'favorite',
                  userId: userId,
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
