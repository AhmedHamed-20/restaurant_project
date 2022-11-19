import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/base_recipes_data_model.dart';

import '../../../../../core/const/const.dart';
import '../../models/favourite_model.dart';
import '../../view_model/bloc/recipes_bloc.dart';

bool favourtiePressed = false;

class OrdersAndCartDetailsButtonsWidget extends StatelessWidget {
  const OrdersAndCartDetailsButtonsWidget({
    required this.recipeDataModel,
    required this.userId,
    Key? key,
  }) : super(key: key);
  final String userId;
  final BaseRecipesDataModel recipeDataModel;
  @override
  Widget build(BuildContext context) {
    var recipesBloc = BlocProvider.of<RecipesBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          height: AppHeight.h46,
          color: AppColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.r25,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Order Now',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
        MaterialButton(
          height: AppHeight.h46,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.r25,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Add to Cart',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
        BlocConsumer<RecipesBloc, RecipesState>(
          listener: (context, state) {
            if (state.inFavoritesDatabase && favourtiePressed) {
              flutterToast(
                msg: 'Recipe In Favorite',
                backgroundColor: AppColors.toastWarning,
                textColor: AppColors.black,
              );
              favourtiePressed = false;
            } else if (state.inFavoritesDatabase == false && favourtiePressed) {
              flutterToast(
                msg: 'Added To Favorite',
                backgroundColor: AppColors.toastSuccess,
                textColor: AppColors.white,
              );
              favourtiePressed = false;
            }
          },
          builder: (context, state) => MaterialButton(
            height: AppHeight.h46,
            color: AppColors.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppRadius.r25,
              ),
            ),
            onPressed: () {
              favourtiePressed = true;
              recipesBloc.add(
                FavouriteCheckIfInDatabaseThenAddEvent(
                  tableName: 'favorite',
                  userId: userId,
                  recipeId: recipeDataModel.recipeId,
                  favouriteModel: FavouriteModel(
                    category: recipeDataModel.category,
                    recipeId: recipeDataModel.recipeId,
                    imageCover: recipeDataModel.imageCover,
                    name: recipeDataModel.name,
                    cookingTime: recipeDataModel.cookingTime,
                    databaseId: 0,
                    ingredients: recipeDataModel.ingredients,
                    price: recipeDataModel.price,
                    slug: recipeDataModel.slug,
                  ),
                ),
              );
            },
            child: Text(
              'Add To Favorite',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
