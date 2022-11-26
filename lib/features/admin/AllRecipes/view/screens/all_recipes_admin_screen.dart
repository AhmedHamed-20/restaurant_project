import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/services/service_locator.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/recipes_admin_bloc.dart';
import '../widgets/main_admin_recipes_widget.dart';

class AllRecipesAdminScreen extends StatelessWidget {
  const AllRecipesAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<RecipesAdminBloc>()
        ..add(const GetRecipesAdminEvent())
        ..add(const CategoryRecipeAdminGetEvent()),
      child: BlocBuilder<RecipesAdminBloc, RecipesAdminState>(
        builder: (context, state) {
          switch (state.recipeAdminRequestStatues) {
            case RecipeAdminRequestStatues.loading:
              return const Center(child: CircularProgressIndicator());
            case RecipeAdminRequestStatues.success:
              return const MainAdminRecipesWidget();
            case RecipeAdminRequestStatues.error:
              return Center(
                  child: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.titleLarge,
              ));
          }
        },
      ),
    );
  }
}
