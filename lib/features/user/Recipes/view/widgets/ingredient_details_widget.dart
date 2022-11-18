import 'package:flutter/material.dart';

import '../../../../../core/const/const.dart';
import '../../models/recipe_data_model.dart';

class IngredientsDetailsWidget extends StatelessWidget {
  const IngredientsDetailsWidget({
    Key? key,
    required this.recipeDataModel,
  }) : super(key: key);

  final RecipeDataModel recipeDataModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.3,
      child: Card(
        elevation: AppElevation.eL2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r10),
        ),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: recipeDataModel.ingredients.length,
            itemBuilder: (context, index) {
              return Center(
                  child: Card(
                      elevation: AppElevation.eL4,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Text(recipeDataModel.ingredients[index]),
                      )));
            }),
      ),
    );
  }
}
