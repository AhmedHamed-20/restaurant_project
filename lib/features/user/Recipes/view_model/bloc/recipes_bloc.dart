import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/user/Recipes/models/recipe_data_model.dart';

import '../../models/favourite_model.dart';
import '../../models/recipes_model.dart';
import '../../repositories/base/base_recipe_repository.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc(this.baseRecipeRepository) : super(const RecipesState()) {
    on<AllRecipesGetEvent>(_getAllRecipes);
    on<RecipesSearchEvent>(_searchRecipes);
    on<FavouriteGetFromDataBaseEvent>(_getAllFavorites);
    on<FavouriteAddToDataBaseEvent>(_insertFavourite);
    on<FavouriteDeleteFromDataBaseEvent>(_deleteFavourite);
    on<AmountRecipesGnerateEvent>(_generateAmountRecipes);
    on<ChangeAmountRecipesEvent>(_changeAmountRecipes);
  }
  final BaseRecipeRepository baseRecipeRepository;
  FutureOr<void> _getAllRecipes(
      AllRecipesGetEvent event, Emitter<RecipesState> emit) async {
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
      add(AmountRecipesGnerateEvent(recipesModel: r.recipeDataModel));
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

  FutureOr<void> _generateAmountRecipes(
      AmountRecipesGnerateEvent event, Emitter<RecipesState> emit) {
    final Map<String, int> amount = {};

    for (var recipe in event.recipesModel) {
      amount[recipe.id] = 1;
    }
    emit(state.copyWith(
      amount: amount,
    ));
  }

  FutureOr<void> _changeAmountRecipes(
      ChangeAmountRecipesEvent event, Emitter<RecipesState> emit) {
    Map<String, int> amountMap = Map.from(state.amount!);
    if (event.isAdd) {
      amountMap[event.recipeId] = amountMap[event.recipeId]! + 1;
      emit(
        state.copyWith(
          amount: Map.from(amountMap),
        ),
      );
    } else {
      if (state.amount![event.recipeId]! > 1) {
        amountMap[event.recipeId] = amountMap[event.recipeId]! - 1;
        emit(
          state.copyWith(
            amount: amountMap,
          ),
        );
      } else {
        emit(state.copyWith(
          amount: amountMap,
        ));
      }
    }
  }
}
