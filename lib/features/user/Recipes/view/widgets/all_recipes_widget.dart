import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/recipes_bloc.dart';

class AllRecipesWidget extends StatelessWidget {
  const AllRecipesWidget({
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
            return Expanded(
              child: ListView.builder(
                  itemCount: state.recipesModel!.recipeDataModel.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutesNames.detailsScreen,
                          arguments: state.recipesModel!.recipeDataModel[index],
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: AppRadius.r40,
                                backgroundImage: NetworkImage(state
                                    .recipesModel!
                                    .recipeDataModel[index]
                                    .imageCover),
                              ),
                              const SizedBox(
                                width: AppWidth.w10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.recipesModel!.recipeDataModel[index]
                                        .name,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    '${state.recipesModel!.recipeDataModel[index].price.toString()} EGP',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
