import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipes_model_admin.dart';
import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';

import '../../../../../core/utls/utls.dart';
import '../../models/recipe_data_admin_model.dart';

part 'recipes_admin_event.dart';
part 'recipes_admin_state.dart';

class RecipesAdminBloc extends Bloc<RecipesAdminEvent, RecipesAdminState> {
  RecipesAdminBloc(this.baseAdminRecipesRepository)
      : super(const RecipesAdminState()) {
    on<GetRecipesAdminEvent>(_getAdminRecipes);
    on<DeleteRecipeAdminEvent>(_deleteRecipe);
    on<UpdateRecipeAdminEvent>(_updateRecipe);
  }
  final BaseAdminRecipesRepository baseAdminRecipesRepository;
  FutureOr<void> _getAdminRecipes(
      GetRecipesAdminEvent event, Emitter<RecipesAdminState> emit) async {
    final result = await baseAdminRecipesRepository.getAdminRecipes();
    result.fold(
      (l) => emit(state.copyWith(
        errorMessage: l.message,
        recipeAdminRequestStatues: RecipeAdminRequestStatues.error,
      )),
      (r) => emit(state.copyWith(
        recipeData: r,
        errorMessage: '',
        recipeAdminRequestStatues: RecipeAdminRequestStatues.success,
      )),
    );
  }

  FutureOr<void> _deleteRecipe(
      DeleteRecipeAdminEvent event, Emitter<RecipesAdminState> emit) async {
    final result = await baseAdminRecipesRepository.deleteRecipe(
        RecipeAdimDeleteParams(
            recipeId: event.recipeId, adminToken: event.adminToken));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              recipeAdminRequestStatues: RecipeAdminRequestStatues.error,
            )), (r) {
      emit(state.copyWith(
        errorMessage: '',
        recipeAdminRequestStatues: RecipeAdminRequestStatues.success,
      ));
      add(const GetRecipesAdminEvent());
    });
  }

  FutureOr<void> _updateRecipe(
      UpdateRecipeAdminEvent event, Emitter<RecipesAdminState> emit) async {
    final result = await baseAdminRecipesRepository.updateRecipe(
      RecipeAdimUpdateParams(
          recipeId: event.recipeId,
          adminToken: event.adminToken,
          recipeData: event.recipeData),
    );
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            recipeAdminRequestStatues: RecipeAdminRequestStatues.error)), (r) {
      emit(state.copyWith(
        errorMessage: '',
        recipeAdminRequestStatues: RecipeAdminRequestStatues.success,
      ));
      add(const GetRecipesAdminEvent());
    });
  }
}
