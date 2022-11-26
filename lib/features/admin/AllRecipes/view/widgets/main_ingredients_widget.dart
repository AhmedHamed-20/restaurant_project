import 'package:flutter/material.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/widget/defaults.dart';
import '../screens/recipe_details_admin_screen.dart';

class MainIngredientsWidget extends StatelessWidget {
  const MainIngredientsWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RecipeDetailsAdminScreen widget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevation.eL4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          children: [
            Text('Ingredients', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppHeight.h10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.recipeDataModel.ingredients.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Defaults.defaultTextField(
                    prefixIcon: Icon(Icons.food_bank_outlined,
                        color: Theme.of(context).iconTheme.color),
                    context: context,
                    controller: TextEditingControllers
                        .recipeEditIngredientsControllers[index],
                    title: 'Ingredient',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
