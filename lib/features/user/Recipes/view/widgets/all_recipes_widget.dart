import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/recipes_bloc.dart';
import 'all_recipes_main_widget.dart';

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
            return const AllRecipesMainWidget();
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
