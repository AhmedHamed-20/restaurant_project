part of 'recipes_admin_bloc.dart';

class RecipesAdminState extends Equatable {
  final RecipesAdminModel? recipeData;
  final String errorMessage;
  final RecipeAdminRequestStatues recipeAdminRequestStatues;

  const RecipesAdminState(
      {this.recipeData,
      this.errorMessage = '',
      this.recipeAdminRequestStatues = RecipeAdminRequestStatues.loading});

  RecipesAdminState copyWith({
    RecipesAdminModel? recipeData,
    String? errorMessage,
    RecipeAdminRequestStatues? recipeAdminRequestStatues,
  }) {
    return RecipesAdminState(
      recipeData: recipeData ?? this.recipeData,
      errorMessage: errorMessage ?? this.errorMessage,
      recipeAdminRequestStatues:
          recipeAdminRequestStatues ?? this.recipeAdminRequestStatues,
    );
  }

  @override
  List<Object?> get props =>
      [recipeData, errorMessage, recipeAdminRequestStatues];
}
