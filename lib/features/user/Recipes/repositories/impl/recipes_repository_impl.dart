import 'package:dartz/dartz.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';

import '../../../../../core/database/date_base_service.dart';
import '../../../../../core/network/network_service.dart';
import '../../models/favorite_model.dart';
import '../../models/recipes_model.dart';
import '../base/base_recipe_repository.dart';

class RecipesRepositoryImpl extends BaseRecipeRepository {
  final NetworkService _networkService;
  final DataBaseService _dataBaseService;
  RecipesRepositoryImpl(this._networkService, this._dataBaseService);
  @override
  Future<Either<Failure, RecipesModel>> getAllRecipes() async {
    try {
      final respone =
          await _networkService.getData(url: EndPoints.allRecipies, headers: {
        'Content-Type': 'application/json',
      });

      return Right(RecipesModel.fromJson(respone.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, RecipesModel>> searchInRecipes(
      SearchParams params) async {
    try {
      final respone =
          await _networkService.getData(url: EndPoints.search, headers: {
        'Content-Type': 'application/json',
      }, query: {
        's': params.query
      });

      return Right(RecipesModel.fromJson(respone.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteModel>>> getAllFavorites(
      AllFavouritesParams params) async {
    try {
      final result = await _dataBaseService.getAllDataFromDatabaseByUserId(
          params.tableName, params.userId);
      return Right(
          List.from(result).map((e) => FavoriteModel.fromMap(e)).toList());
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertFavourite(
      FavouriteInsertParams params) async {
    try {
      final favouriteMap = params.favouriteModel.toMap();

      final result = await _dataBaseService.insertIntoDataBase(
        data: [
          params.userId,
          favouriteMap['name'],
          favouriteMap['imageCover'],
          favouriteMap['price'],
          favouriteMap['slug'],
          favouriteMap['recipeId'],
          favouriteMap['category'],
          favouriteMap['cookingTime'],
          favouriteMap['ingredients'],
        ],
        query:
            'INSERT INTO ${params.tableName}(userId ,name, imageCover,price,slug,recipeId,category,cookingTime,ingredients) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)',
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteFavourite(
      FavouriteDeleteParams params) async {
    try {
      final result =
          await _dataBaseService.deleteDataFromDatabaseByDataBaseIdAndUserId(
              dataBaseId: params.databaseId,
              tableName: params.tableName,
              userId: params.userId);
      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteModel>>> getAllFavoritesByRecipeId(
      FavoriteGetByRecipeIdParams params) async {
    try {
      final result =
          await _dataBaseService.getAllDataFromDatabaseByRecipeIdAndUserId(
              tableName: params.tableName,
              recipeId: params.recipeId,
              userId: params.userId);

      return Right(
          List.from(result).map((e) => FavoriteModel.fromMap(e)).toList());
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecipesModel>> getMoreRecipes(
      MoreRecipesGetParams params) async {
    try {
      final respone = await _networkService
          .getData(url: EndPoints.allRecipiesPage + params.page, headers: {
        'Content-Type': 'application/json',
      });
      return Right(RecipesModel.fromJson(respone.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
