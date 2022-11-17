part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();
}

class AllRecipesEvent extends RecipesEvent {
  const AllRecipesEvent();

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
