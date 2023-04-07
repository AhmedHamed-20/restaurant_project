part of 'recipes_admin_bloc.dart';

class RecipesAdminState extends Equatable {
  final RecipesAdminModel? recipeData;
  final String errorMessage;
  final RecipeAdminRequestStatues recipeAdminRequestStatues;
  final RecipeAdminRequestStatues categoiesRecipeAdminRequestStatues;
  final RecipeAdminUpdateRequestStatues recipeAdminUpdateRequestStatues;
  final RecipeAdminDeleteRequestStatues recipeAdminDeleteRequestStatues;
  final RecipeAdminAddRequestStatues recipeAdminAddRequestStatues;
  final bool isEndOfRecipes;
  final RecipeAdminRequestStatues moreRecipesGetRequestStatues;
  final List<String> categories;
  final String pickedImage;
  final RecipeAdminRequestStatues imagePickRequestStatues;

  const RecipesAdminState(
      {this.recipeData,
      this.errorMessage = '',
      this.pickedImage = '',
      this.recipeAdminAddRequestStatues = RecipeAdminAddRequestStatues.idle,
      this.recipeAdminUpdateRequestStatues =
          RecipeAdminUpdateRequestStatues.idle,
      this.imagePickRequestStatues = RecipeAdminRequestStatues.loading,
      this.categoiesRecipeAdminRequestStatues =
          RecipeAdminRequestStatues.loading,
      this.categories = const [],
      this.moreRecipesGetRequestStatues = RecipeAdminRequestStatues.loading,
      this.isEndOfRecipes = false,
      this.recipeAdminDeleteRequestStatues =
          RecipeAdminDeleteRequestStatues.idle,
      this.recipeAdminRequestStatues = RecipeAdminRequestStatues.loading});

  RecipesAdminState copyWith({
    RecipeAdminAddRequestStatues? recipeAdminAddRequestStatues,
    RecipeAdminUpdateRequestStatues? recipeAdminUpdateRequestStatues,
    RecipeAdminRequestStatues? imagePickRequestStatues,
    String? pickedImage,
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
      recipeAdminAddRequestStatues:
          recipeAdminAddRequestStatues ?? this.recipeAdminAddRequestStatues,
      recipeAdminUpdateRequestStatues: recipeAdminUpdateRequestStatues ??
          this.recipeAdminUpdateRequestStatues,
      imagePickRequestStatues:
          imagePickRequestStatues ?? this.imagePickRequestStatues,
      pickedImage: pickedImage ?? this.pickedImage,
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
        pickedImage,
        errorMessage,
        recipeAdminAddRequestStatues,
        recipeAdminUpdateRequestStatues,
        imagePickRequestStatues,
        categoiesRecipeAdminRequestStatues,
        recipeAdminRequestStatues,
        recipeAdminDeleteRequestStatues,
        isEndOfRecipes,
        moreRecipesGetRequestStatues,
        categories,
        identityHashCode(this),
      ];
}
