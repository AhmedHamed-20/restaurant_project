import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/const/text_editing_controllers.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';
import 'package:resturant/features/admin/AllRecipes/view/widgets/recipe_main_information_widget.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/recipes_admin_bloc.dart';

class SaveEditDialogWidget extends StatelessWidget {
  const SaveEditDialogWidget({
    Key? key,
    required this.recipeId,
  }) : super(key: key);
  final String recipeId;
  @override
  Widget build(BuildContext context) {
    var recipesAdminBloc = BlocProvider.of<RecipesAdminBloc>(context);
    return BlocConsumer<RecipesAdminBloc, RecipesAdminState>(
      listener: (context, state) {
        if (state.recipeAdminUpdateRequestStatues ==
            RecipeAdminUpdateRequestStatues.success) {
          flutterToast(
              msg: 'Updated Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.pop(context);
        } else if (state.recipeAdminUpdateRequestStatues ==
            RecipeAdminUpdateRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.pop(context);
        }
      },
      builder: (context, state) => AlertDialog(
        title: Text(
          'Are you sure you want to save edit?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: Theme.of(context).textTheme.titleMedium,
              )),
          TextButton(
              onPressed: () {
                final List<dynamic> ingredientsList =
                    recipesAdminBloc.getIngredientsList(
                        ingredients: TextEditingControllers
                            .recipeEditIngredientsControllers); // recipesAdminBloc.add(
                recipesAdminBloc.add(UpdateRecipeAdminEvent(
                  adminToken: accessTokenAdminVar,
                  recipeId: recipeId,
                  recipeData: RecipeAdminDataModel(
                    ingredients: ingredientsList,
                    imageCover:
                        state.pickedImage == '' ? '' : state.pickedImage,
                    category: newCategory,
                    cookingTime: int.parse(
                      TextEditingControllers
                          .recipeCookingTimeAdminEditScreenController.text
                          .trim(),
                    ),
                    id: recipeId,
                    price: int.parse(
                      TextEditingControllers
                          .recipePriceAdminEditScreenController.text
                          .trim(),
                    ),
                    name: TextEditingControllers
                        .recipeNameAdminEditScreenController.text
                        .trim(),
                    slug: '',
                  ),
                ));
              },
              child:
                  Text('Yes', style: Theme.of(context).textTheme.titleMedium)),
        ],
      ),
    );
  }
}
