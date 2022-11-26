import 'package:dio/dio.dart';
import 'package:resturant/features/admin/AllRecipes/models/category_admin_recipe_model.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipes_model_admin.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';

import '../../../../../core/network/dio.dart';
import '../../../../../core/network/endpoints.dart';

class RemoteAdminRecipesRepository extends BaseAdminRecipesRepository {
  @override
  Future<Either<Failure, RecipesAdminModel>> getAdminRecipes() async {
    try {
      final respone =
          await DioHelper.getData(url: EndPoints.allRecipies, headers: {
        'Content-Type': 'application/json',
      });

      return Right(RecipesAdminModel.fromJson(respone?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, String>> deleteRecipe(
      RecipeAdimDeleteParams params) async {
    try {
      final respone = await DioHelper.deleteData(
        url: EndPoints.allRecipies + params.recipeId,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return Right(respone?.data['message']);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, String>> updateRecipe(
      RecipeAdimUpdateParams params) async {
    try {
      final recipeMap = params.recipeData.toMap();
      final reponse = await DioHelper.patchData(
        url: EndPoints.allRecipies + params.recipeId,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
        data: recipeMap,
      );
      return Right(reponse?.data['message']);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, RecipesAdminModel>> getMoreAdminRecipes(
      MoreAdminRecipesGetParams params) async {
    try {
      final reponse = await DioHelper.getData(
        url: EndPoints.allRecipiesPage + params.page,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return Right(RecipesAdminModel.fromJson(reponse?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, CategoryRecipeAdminModel>> getCategories() async {
    try {
      final reponse = await DioHelper.getData(
        url: EndPoints.categories,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return Right(CategoryRecipeAdminModel.fromJson(reponse?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }
}
