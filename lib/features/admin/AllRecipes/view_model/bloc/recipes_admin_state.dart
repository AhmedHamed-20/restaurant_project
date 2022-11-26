part of 'recipes_admin_bloc.dart';

class RecipesAdminState extends Equatable {
  final RecipesAdminModel? recipeData;
  final String errorMessage;
  final RecipeAdminRequestStatues recipeAdminRequestStatues;
  final RecipeAdminRequestStatues categoiesRecipeAdminRequestStatues;

  final RecipeAdminDeleteRequestStatues recipeAdminDeleteRequestStatues;
  final bool isEndOfRecipes;
  final RecipeAdminRequestStatues moreRecipesGetRequestStatues;
  final List<String> categories;
  const RecipesAdminState(
      {this.recipeData,
      this.errorMessage = '',
      this.categoiesRecipeAdminRequestStatues =
          RecipeAdminRequestStatues.loading,
      this.categories = const [],
      this.moreRecipesGetRequestStatues = RecipeAdminRequestStatues.loading,
      this.isEndOfRecipes = false,
      this.recipeAdminDeleteRequestStatues =
          RecipeAdminDeleteRequestStatues.idle,
      this.recipeAdminRequestStatues = RecipeAdminRequestStatues.loading});

  RecipesAdminState copyWith({
    RecipeAdminRequestStatues? categoiesRecipeAdminRequestStatues,
    List<String>? categories,
    RecipeAdminRequestStatues? moreRecipesGetRequestStatues,
    bool? isEndOfRecipes,
    RecipeAdminDeleteRequestStatues? recipeAdminDeleteRequestStatues,
    RecipesAdminModel? recipeData,
    String? errorMessage,
    RecipeAdminRequestStatues? recipeAdminRequestStatues,
  }) {
    return RecipesAdminState(
      categoiesRecipeAdminRequestStatues: categoiesRecipeAdminRequestStatues ??
          this.categoiesRecipeAdminRequestStatues,
      categories: categories ?? this.categories,
      moreRecipesGetRequestStatues:
          moreRecipesGetRequestStatues ?? this.moreRecipesGetRequestStatues,
      isEndOfRecipes: isEndOfRecipes ?? this.isEndOfRecipes,
      recipeAdminDeleteRequestStatues: recipeAdminDeleteRequestStatues ??
          this.recipeAdminDeleteRequestStatues,
      recipeData: recipeData ?? this.recipeData,
      errorMessage: errorMessage ?? this.errorMessage,
      recipeAdminRequestStatues:
          recipeAdminRequestStatues ?? this.recipeAdminRequestStatues,
    );
  }

  @override
  List<Object?> get props => [
        recipeData,
        errorMessage,
        categoiesRecipeAdminRequestStatues,
        recipeAdminRequestStatues,
        recipeAdminDeleteRequestStatues,
        isEndOfRecipes,
        moreRecipesGetRequestStatues,
        categories,
        identityHashCode(this),
      ];
}
