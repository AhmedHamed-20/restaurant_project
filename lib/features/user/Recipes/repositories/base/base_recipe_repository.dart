import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';

import '../../models/favourite_model.dart';
import '../../models/recipes_model.dart';

abstract class BaseRecipeRepository {
  Future<Either<Failure, RecipesModel>> getAllRecipes();
  Future<Either<Failure, RecipesModel>> getMoreRecipes(
      MoreRecipesGetParams params);

  Future<Either<Failure, RecipesModel>> searchInRecipes(SearchParams params);
  Future<Either<Failure, List<FavouriteModel>>> getAllFavorites(
      AllFavouritesParams params);
  Future<Either<Failure, void>> insertFavourite(FavouriteInsertParams params);
  Future<Either<Failure, int>> deleteFavourite(FavouriteDeleteParams params);
  Future<Either<Failure, List<FavouriteModel>>> getAllFavoritesByRecipeId(
      FavoriteGetByRecipeIdParams params);
}

class SearchParams extends Equatable {
  final String query;

  const SearchParams({required this.query});

  @override
  List<Object?> get props => [query];
}

class AllFavouritesParams extends Equatable {
  final String tableName;
  final String userId;

  const AllFavouritesParams({required this.tableName, required this.userId});

  @override
  List<Object?> get props => [tableName, userId];
}

class FavouriteInsertParams extends Equatable {
  final FavouriteModel favouriteModel;
  final String tableName;
  final String userId;

  const FavouriteInsertParams(
      {required this.favouriteModel,
      required this.tableName,
      required this.userId});
  @override
  List<Object?> get props => [favouriteModel, tableName, userId];
}

class FavouriteDeleteParams extends Equatable {
  final String tableName;
  final String userId;
  final int databaseId;

  const FavouriteDeleteParams(
      {required this.tableName,
      required this.userId,
      required this.databaseId});
  @override
  List<Object?> get props => [tableName, userId, databaseId];
}

class FavoriteGetByRecipeIdParams extends Equatable {
  final String tableName;
  final String userId;
  final String recipeId;

  const FavoriteGetByRecipeIdParams(
      {required this.tableName, required this.userId, required this.recipeId});

  @override
  List<Object?> get props => [tableName, userId, recipeId];
}

class MoreRecipesGetParams extends Equatable {
  final String page;

  const MoreRecipesGetParams({
    required this.page,
  });

  @override
  List<Object?> get props => [
        page,
      ];
}
