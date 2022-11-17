import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipes_model_admin.dart';

import '../../../../../core/error/failure.dart';

abstract class BaseAdminRecipesRepository {
  Future<Either<Failure, RecipesAdminModel>> getAdminRecipes();
  Future<Either<Failure, String>> deleteRecipe(RecipeAdimDeleteParams params);
  Future<Either<Failure, String>> updateRecipe(RecipeAdimUpdateParams params);
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
