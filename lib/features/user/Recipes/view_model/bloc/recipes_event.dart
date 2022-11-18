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
