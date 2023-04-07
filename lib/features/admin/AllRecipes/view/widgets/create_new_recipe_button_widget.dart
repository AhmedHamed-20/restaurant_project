import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';

import '../../../../../core/utls/utls.dart';
import 'create_recipe_button_design.dart';

class CreateNewRecipeButton extends StatelessWidget {
  const CreateNewRecipeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipesAdminBloc, RecipesAdminState>(
      listener: (context, state) {
        if (state.recipeAdminAddRequestStatues ==
            RecipeAdminAddRequestStatues.success) {
          flutterToast(
              msg: 'created success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.pop(context);
        } else if (state.recipeAdminAddRequestStatues ==
            RecipeAdminAddRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
        }
      },
      builder: (context, state) {
        switch (state.recipeAdminAddRequestStatues) {
          case RecipeAdminAddRequestStatues.idle:
            return CreateRecipeButtonDesignWidget(
              imagePath: state.pickedImage,
            );
          case RecipeAdminAddRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case RecipeAdminAddRequestStatues.success:
            return CreateRecipeButtonDesignWidget(
              imagePath: state.pickedImage,
            );
          case RecipeAdminAddRequestStatues.error:
            return CreateRecipeButtonDesignWidget(
              imagePath: state.pickedImage,
            );
        }
      },
    );
  }
}
