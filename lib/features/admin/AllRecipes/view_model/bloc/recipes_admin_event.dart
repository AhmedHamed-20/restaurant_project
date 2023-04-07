part of 'recipes_admin_bloc.dart';

abstract class RecipesAdminEvent extends Equatable {
  const RecipesAdminEvent();
}

class GetRecipesAdminEvent extends RecipesAdminEvent {
  const GetRecipesAdminEvent();

  @override
  List<Object> get props => [];
}

class DeleteRecipeAdminEvent extends RecipesAdminEvent {
  final String recipeId;
  final String adminToken;
  const DeleteRecipeAdminEvent(
      {required this.recipeId, required this.adminToken});

  @override
  List<Object> get props => [recipeId, adminToken];
}

class UpdateRecipeAdminEvent extends RecipesAdminEvent {
  final String adminToken;
  final String recipeId;
  final RecipeAdminDataModel recipeData;
  const UpdateRecipeAdminEvent(
      {required this.adminToken,
      required this.recipeId,
      required this.recipeData});

  @override
  List<Object?> get props => [adminToken, recipeId, recipeData];
}

class RecipesAdminGetMoreEvent extends RecipesAdminEvent {
  final int page;
  const RecipesAdminGetMoreEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class CategoryRecipeAdminGetEvent extends RecipesAdminEvent {
  const CategoryRecipeAdminGetEvent();

  @override
  List<Object?> get props => [];
}

class ImagePickEvent extends RecipesAdminEvent {
  const ImagePickEvent();

  @override
  List<Object?> get props => [];
}

class ImagePickedResetEvent extends RecipesAdminEvent {
  const ImagePickedResetEvent();

  @override
  List<Object?> get props => [];
}

class AddRecipeAdminEvent extends RecipesAdminEvent {
  final String adminToken;
  final RecipeAdminDataModel recipeData;
  final String imagePath;
  const AddRecipeAdminEvent(
      {required this.adminToken,
      required this.recipeData,
      required this.imagePath});

  @override
  List<Object?> get props => [adminToken, recipeData, imagePath];
}
