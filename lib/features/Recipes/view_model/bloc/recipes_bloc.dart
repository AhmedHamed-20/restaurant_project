import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/Recipes/models/recipes_model.dart';
import 'package:resturant/features/Recipes/repositories/base/base_recipe_repository.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc(this.baseRecipeRepository) : super(const RecipesState()) {
    on<AllRecipesEvent>(_getAllRecipes);
    on<RecipesSearchEvent>(_searchRecipes);
  }
  final BaseRecipeRepository baseRecipeRepository;
  FutureOr<void> _getAllRecipes(
      AllRecipesEvent event, Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository.getAllRecipes();

    result.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        recipeRequestStatues: RecipeRequestStatues.error,
      ));
    }, (r) {
      emit(state.copyWith(
        recipesModel: r,
        errorMessage: '',
        recipeRequestStatues: RecipeRequestStatues.success,
      ));
    });
  }

  FutureOr<void> _searchRecipes(
      RecipesSearchEvent event, Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository
        .searchInRecipes(SearchParams(query: event.query));
    result.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        searchRequestStatues: RecipeRequestStatues.error,
      ));
    }, (r) {
      emit(state.copyWith(
        searchModel: r,
        errorMessage: '',
        searchRequestStatues: RecipeRequestStatues.success,
      ));
    });
  }
}
