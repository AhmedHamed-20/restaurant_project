import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';

import '../../models/favourite_model.dart';
import '../../models/recipes_model.dart';
import '../../repositories/base/base_recipe_repository.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc(this.baseRecipeRepository) : super(const RecipesState()) {
    on<AllRecipesEvent>(_getAllRecipes);
    on<RecipesSearchEvent>(_searchRecipes);
    on<FavouriteGetFromDataBaseEvent>(_getAllFavorites);
    on<FavouriteAddToDataBaseEvent>(_insertFavourite);
    on<FavouriteDeleteFromDataBaseEvent>(_deleteFavourite);
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

  FutureOr<void> _getAllFavorites(
      FavouriteGetFromDataBaseEvent event, Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository.getAllFavorites(
        AllFavouritesParams(tableName: event.tableName, userId: event.userId));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              favouriteRequestStatues: RecipeRequestStatues.error,
            )),
        (r) => emit(state.copyWith(
              favouriteModel: r,
              errorMessage: '',
              favouriteRequestStatues: RecipeRequestStatues.success,
            )));
  }

  FutureOr<void> _insertFavourite(
      FavouriteAddToDataBaseEvent event, Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository.insertFavourite(
        FavouriteInsertParams(
            favouriteModel: event.favouriteModel,
            tableName: event.tableName,
            userId: event.userId));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      emit(state.copyWith(
        errorMessage: '',
      ));

      add(FavouriteGetFromDataBaseEvent(
          tableName: event.tableName, userId: event.userId));
    });
  }

  FutureOr<void> _deleteFavourite(FavouriteDeleteFromDataBaseEvent event,
      Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository.deleteFavourite(
        FavouriteDeleteParams(
            tableName: event.tableName,
            userId: event.userId,
            databaseId: event.databaseId));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      emit(state.copyWith(
        errorMessage: '',
      ));

      add(FavouriteGetFromDataBaseEvent(
          tableName: event.tableName, userId: event.userId));
    });
  }
}
