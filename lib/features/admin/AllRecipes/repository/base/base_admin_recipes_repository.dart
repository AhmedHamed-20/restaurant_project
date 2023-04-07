import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipes_model_admin.dart';

import '../../../../../core/error/failure.dart';
import '../../models/category_admin_recipe_model.dart';

abstract class BaseAdminRecipesRepository {
  Future<Either<Failure, RecipesAdminModel>> getAdminRecipes(
      AdminRecipesGetParams params);
  Future<Either<Failure, String>> deleteRecipe(RecipeAdimDeleteParams params);
  Future<Either<Failure, String>> updateRecipe(RecipeAdimUpdateParams params);
  Future<Either<Failure, CategoryRecipeAdminModel>> getCategories();
  Future<Either<Failure, void>> addRecipe(RecipeAddParams params);
}

class RecipeAdimDeleteParams extends Equatable {
  final String recipeId;
  final String adminToken;
  const RecipeAdimDeleteParams(
      {required this.recipeId, required this.adminToken});

  @override
  List<Object> get props => [recipeId, adminToken];
}

class RecipeAdimUpdateParams extends Equatable {
  final String adminToken;
  final String recipeId;
  final RecipeAdminDataModel recipeData;

  const RecipeAdimUpdateParams(
      {required this.adminToken,
      required this.recipeId,
      required this.recipeData});

  @override
  List<Object?> get props => [adminToken, recipeId, recipeData];
}

class AdminRecipesGetParams extends Equatable {
  final int page;

  const AdminRecipesGetParams({required this.page});

  @override
  List<Object> get props => [page];
}

class RecipeAddParams extends Equatable {
  final String adminToken;
  final String imagePath;
  final RecipeAdminDataModel recipeData;

  const RecipeAddParams(
      {required this.adminToken,
      required this.recipeData,
      required this.imagePath});

  @override
  List<Object?> get props => [adminToken, recipeData];
}
