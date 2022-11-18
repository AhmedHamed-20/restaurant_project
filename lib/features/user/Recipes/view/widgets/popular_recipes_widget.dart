import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/recipes_bloc.dart';

class PopularRecipesWidget extends StatelessWidget {
  const PopularRecipesWidget({
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
            return SizedBox(
              width: screenWidth(context),
              height: screenHeight(context) * 0.2,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutesNames.detailsScreen,
                            arguments:
                                state.recipesModel!.recipeDataModel[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p10),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: AppRadius.r40,
                              backgroundImage: NetworkImage(state.recipesModel!
                                  .recipeDataModel[index].imageCover),
                            ),
                            const SizedBox(
                              height: AppHeight.h10,
                            ),
                            Text(
                              state.recipesModel!.recipeDataModel[index].name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
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
