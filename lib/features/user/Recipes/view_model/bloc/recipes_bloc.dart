import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/user/Recipes/models/cart_model.dart';
import 'package:resturant/features/user/Recipes/models/recipe_data_model.dart';

import '../../models/favorite_model.dart';
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
    on<FavouriteCheckIfInDatabaseThenAddEvent>(
        _checkIfRecipeInFavouriteThenAdd);
    on<CartAddEvent>(_addToCart);
    on<AddToCartResetBooleanEvent>(_resetAddToCartBoolean);
    on<CartRemoveEvent>(_removeFromCart);
    on<CartRemoveAllEvent>(_removeAllFromCart);
    on<MoreRecipesGetEvent>(_getMoreRecipes);
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
      if (r.results < 10 || r.results == 0) {
        emit(state.copyWith(
          recipesModel: r,
          errorMessage: '',
          isEndOfData: true,
          recipeRequestStatues: RecipeRequestStatues.success,
        ));
      } else {
        emit(state.copyWith(
          recipesModel: r,
          errorMessage: '',
          isEndOfData: false,
          recipeRequestStatues: RecipeRequestStatues.success,
        ));
      }
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
      amount[recipe.recipeId] = 1;
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

  FutureOr<void> _checkIfRecipeInFavouriteThenAdd(
      FavouriteCheckIfInDatabaseThenAddEvent event,
      Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository.getAllFavoritesByRecipeId(
      FavoriteGetByRecipeIdParams(
        tableName: event.tableName,
        userId: event.userId,
        recipeId: event.recipeId,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      if (r.isEmpty) {
        emit(state.copyWith(
          errorMessage: '',
          inFavoritesDatabase: false,
        ));
        add(FavouriteAddToDataBaseEvent(
          tableName: event.tableName,
          userId: event.userId,
          favouriteModel: event.favouriteModel,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: '',
          inFavoritesDatabase: true,
        ));
      }
    });
  }

  FutureOr<void> _addToCart(CartAddEvent event, Emitter<RecipesState> emit) {
    List<CartModel> mycartModel = [];
    bool isExist = false;
    if (state.cartModel.isEmpty) {
      mycartModel.add(event.cartModel);
      emit(state.copyWith(
        cartModel: List.from(mycartModel),
        errorMessage: '',
        addedToCart: true,
      ));
    } else {
      for (var element in state.cartModel) {
        if (element.recipeId == event.cartModel.recipeId) {
          isExist = true;
          break;
        } else {
          isExist = false;
        }
      }
      if (isExist) {
        emit(
          state.copyWith(
            errorMessage: 'Already in cart',
            addedToCart: false,
          ),
        );
      } else {
        mycartModel = state.cartModel;
        mycartModel.add(event.cartModel);

        emit(state.copyWith(
          cartModel: List.from(mycartModel),
          errorMessage: '',
          addedToCart: true,
        ));
      }
    }
  }

  FutureOr<void> _resetAddToCartBoolean(
      AddToCartResetBooleanEvent event, Emitter<RecipesState> emit) async {
    emit(state.copyWith(addedToCart: false, errorMessage: ''));
  }

  FutureOr<void> _removeFromCart(
      CartRemoveEvent event, Emitter<RecipesState> emit) async {
    List<CartModel> mycartModel = List.from(state.cartModel);
    mycartModel.removeWhere((element) => element.recipeId == event.recipeId);
    emit(state.copyWith(
      cartModel: mycartModel,
      errorMessage: '',
    ));
  }

  FutureOr<void> _removeAllFromCart(
      CartRemoveAllEvent event, Emitter<RecipesState> emit) async {
    emit(state.copyWith(
      cartModel: const [],
      errorMessage: '',
    ));
  }

  FutureOr<void> _getMoreRecipes(
      MoreRecipesGetEvent event, Emitter<RecipesState> emit) async {
    final result = await baseRecipeRepository.getMoreRecipes(
      MoreRecipesGetParams(
        page: event.page,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              isEndOfData: false,
            )), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          errorMessage: '',
          isEndOfData: true,
          moreRecipesGetRequestStatues: RecipeRequestStatues.success,
        ));
      } else if (r.results == 10) {
        RecipesModel myRecipesModel;
        myRecipesModel = state.recipesModel!;

        myRecipesModel.recipeDataModel.addAll(List.from(r.recipeDataModel));

        emit(state.copyWith(
          errorMessage: '',
          recipesModel: myRecipesModel,
          isEndOfData: false,
          moreRecipesGetRequestStatues: RecipeRequestStatues.success,
        ));
      } else {
        RecipesModel myRecipesModel = state.recipesModel!;
        myRecipesModel.recipeDataModel.addAll(List.from(r.recipeDataModel));
        emit(
          state.copyWith(
            errorMessage: '',
            recipesModel: myRecipesModel,
            isEndOfData: true,
            moreRecipesGetRequestStatues: RecipeRequestStatues.success,
          ),
        );
      }
    });
  }
}
