import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../models/recipes_model.dart';
import '../base/base_recipe_repository.dart';

class RemoteRecipesRepositoryImpl extends BaseRecipeRepository {
  @override
  Future<Either<Failure, RecipesModel>> getAllRecipes() async {
    try {
      final respone =
          await DioHelper.getData(url: EndPoints.allRecipies, headers: {
        'Content-Type': 'application/json',
      });

      return Right(RecipesModel.fromJson(respone?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, RecipesModel>> searchInRecipes(
      SearchParams params) async {
    try {
      final respone = await DioHelper.getData(url: EndPoints.search, headers: {
        'Content-Type': 'application/json',
      }, query: {
        's': params.query
      });

      return Right(RecipesModel.fromJson(respone?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
