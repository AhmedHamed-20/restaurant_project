import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resturant/core/const/base_recipes_data_model.dart';

import '../../../../../core/const/const.dart';

class IngredientsDetailsWidget extends StatelessWidget {
  const IngredientsDetailsWidget({
    Key? key,
    required this.recipeDataModel,
  }) : super(key: key);

  final BaseRecipesDataModel recipeDataModel;

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
          itemCount: recipeDataModel.ingredients.length,
          itemBuilder: (context, index) {
            return Center(
              child: Card(
                elevation: AppElevation.eL4,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p4),
                  child: Text(
                    recipeDataModel.ingredients[index],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
        ),
      ),
    );
  }
}
