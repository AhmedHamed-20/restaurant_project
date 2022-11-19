part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();
}

class AllRecipesGetEvent extends RecipesEvent {
  const AllRecipesGetEvent();

  @override
  List<Object?> get props => [];
}

class RecipesSearchEvent extends RecipesEvent {
  final String query;

  const RecipesSearchEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class FavouriteAddToDataBaseEvent extends RecipesEvent {
  final FavouriteModel favouriteModel;
  final String tableName;
  final String userId;

  const FavouriteAddToDataBaseEvent(
      {required this.favouriteModel,
      required this.tableName,
      required this.userId});

  @override
  List<Object?> get props => [favouriteModel, tableName, userId];
}

class FavouriteGetFromDataBaseEvent extends RecipesEvent {
  final String tableName;
  final String userId;

  const FavouriteGetFromDataBaseEvent(
      {required this.tableName, required this.userId});

  @override
  List<Object?> get props => [tableName, userId];
}

class FavouriteDeleteFromDataBaseEvent extends RecipesEvent {
  final String tableName;
  final String userId;
  final int databaseId;

  const FavouriteDeleteFromDataBaseEvent(
      {required this.tableName,
      required this.userId,
      required this.databaseId});

  @override
  List<Object?> get props => [tableName, userId, databaseId];
}

class AmountRecipesGnerateEvent extends RecipesEvent {
  final List<RecipeDataModel> recipesModel;

  const AmountRecipesGnerateEvent({required this.recipesModel});

  @override
  List<Object?> get props => [recipesModel];
}

class ChangeAmountRecipesEvent extends RecipesEvent {
  final String recipeId;
  final bool isAdd;

  const ChangeAmountRecipesEvent({required this.recipeId, required this.isAdd});

  @override
  List<Object?> get props => [recipeId, isAdd];
}

class FavouriteCheckIfInDatabaseThenAddEvent extends RecipesEvent {
  final String tableName;
  final String userId;
  final String recipeId;
  final FavouriteModel favouriteModel;
  const FavouriteCheckIfInDatabaseThenAddEvent(
      {required this.tableName,
      required this.userId,
      required this.recipeId,
      required this.favouriteModel});

  @override
  List<Object?> get props => [tableName, userId, recipeId, favouriteModel];
}

class CartAddEvent extends RecipesEvent {
  final CartModel cartModel;

  const CartAddEvent({
    required this.cartModel,
  });

  @override
  List<Object?> get props => [
        cartModel,
      ];
}

class AddToCartResetBooleanEvent extends RecipesEvent {
  const AddToCartResetBooleanEvent();

  @override
  List<Object?> get props => [];
}

class CartRemoveEvent extends RecipesEvent {
  final String recipeId;

  const CartRemoveEvent({
    required this.recipeId,
  });

  @override
  List<Object?> get props => [
        recipeId,
      ];
}

class CartRemoveAllEvent extends RecipesEvent {
  const CartRemoveAllEvent();

  @override
  List<Object?> get props => [];
}
