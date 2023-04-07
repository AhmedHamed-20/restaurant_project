import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/features/admin/AllRecipes/models/category_admin_recipe_model.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipes_model_admin.dart';
import 'package:resturant/features/admin/AllRecipes/repository/base/base_admin_recipes_repository.dart';

import '../../../../../core/network/endpoints.dart';
import '../../../../../core/network/network_service.dart';

class RemoteAdminRecipesRepository extends BaseAdminRecipesRepository {
  final NetworkService _networkService;

  RemoteAdminRecipesRepository(this._networkService);
  @override
  Future<Either<Failure, RecipesAdminModel>> getAdminRecipes(
      AdminRecipesGetParams params) async {
    try {
      final respone =
          await _networkService.getData(url: EndPoints.allRecipies, headers: {
        'Content-Type': 'application/json',
      }, query: {
        'page': params.page,
      });

      return Right(RecipesAdminModel.fromJson(respone.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteRecipe(
      RecipeAdimDeleteParams params) async {
    try {
      final respone = await _networkService.deleteData(
        url: EndPoints.allRecipies + params.recipeId,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return Right(respone?.data['message']);
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateRecipe(
      RecipeAdimUpdateParams params) async {
    try {
      if (params.recipeData.imageCover == '') {
        final map = params.recipeData.toMapWithoutImage();
        final reponse = await _networkService.patchData(
          url: EndPoints.allRecipies + params.recipeId,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${params.adminToken}',
          },
          data: map,
        );
        return Right(reponse?.data['message'] ?? '');
      } else {
        final map = await params.recipeData
            .toMapWithImage(params.recipeData.imageCover);
        final reponse = await _networkService.patchData(
          url: EndPoints.allRecipies + params.recipeId,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${params.adminToken}',
          },
          data: FormData.fromMap(map),
        );
        return Right(reponse?.data['message'] ?? '');
      }
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, CategoryRecipeAdminModel>> getCategories() async {
    try {
      final reponse = await _networkService.getData(
        url: EndPoints.categories,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return Right(CategoryRecipeAdminModel.fromJson(reponse.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> addRecipe(RecipeAddParams params) async {
    try {
      final recipeData =
          await params.recipeData.toMapWithImage(params.imagePath);
      await _networkService.postData(
          url: EndPoints.allRecipies,
          data: FormData.fromMap(recipeData),
          headers: {
            'Authorization': 'Bearer ${params.adminToken}',
          });
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
