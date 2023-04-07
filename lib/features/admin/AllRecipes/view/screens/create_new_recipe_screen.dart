import 'package:flutter/material.dart';
import 'package:resturant/core/const/const.dart';

import '../widgets/add_new_recipe_image_widget.dart';
import '../widgets/create_new_recipe_button_widget.dart';
import '../widgets/main_ingredients_widget.dart';
import '../widgets/recipe_main_information_widget.dart';

class CreateNewRecipeScreen extends StatelessWidget {
  const CreateNewRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: Text(
          'Create New Recipe',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: const [
          CreateNewRecipeButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: const [
              AddNewRecipeImageWidget(),
              SizedBox(height: AppHeight.h10),
              RecipeMainInformationWidget(),
              SizedBox(height: AppHeight.h10),
              MainIngredientsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
