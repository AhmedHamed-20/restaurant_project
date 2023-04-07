import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/text_editing_controllers.dart';
import 'package:resturant/features/admin/AllRecipes/view/widgets/recipe_main_information_widget.dart';

import '../../../../../core/const/const.dart';
import '../../models/recipe_data_admin_model.dart';
import '../../view_model/bloc/recipes_admin_bloc.dart';

class CreateRecipeButtonDesignWidget extends StatelessWidget {
  const CreateRecipeButtonDesignWidget({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final allRecipesAdminBloc = BlocProvider.of<RecipesAdminBloc>(context);
    return IconButton(
      onPressed: () {
        final ingredientsList = TextEditingControllers
            .recipeEditIngredientsControllers
            .map((e) => e.text)
            .toList();
        final recipeAdminDataModel = RecipeAdminDataModel(
            category: newCategory,
            cookingTime: int.parse(
              TextEditingControllers
                  .recipeCookingTimeAdminScreenController.text,
            ),
            id: '',
            name: TextEditingControllers.recipeNameAdminScreenController.text,
            ingredients: ingredientsList,
            price: int.parse(
                TextEditingControllers.recipePriceAdminScreenController.text),
            slug: '',
            imageCover: imagePath);
        allRecipesAdminBloc.add(
          AddRecipeAdminEvent(
            adminToken: accessTokenAdminVar,
            imagePath: imagePath,
            recipeData: recipeAdminDataModel,
          ),
        );
      },
      icon: Icon(
        Icons.save,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
