part of 'recipes_bloc.dart';

class RecipesState extends Equatable {
  final String errorMessage;
  final RecipesModel? recipesModel;
  final RecipesModel? searchModel;
  final RecipeRequestStatues recipeRequestStatues;
  final RecipeRequestStatues searchRequestStatues;

  const RecipesState(
      {this.errorMessage = '',
      this.recipesModel,
      this.searchModel,
      this.recipeRequestStatues = RecipeRequestStatues.loading,
      this.searchRequestStatues = RecipeRequestStatues.loading});

  RecipesState copyWith({
    String? errorMessage,
    RecipesModel? recipesModel,
    RecipesModel? searchModel,
    RecipeRequestStatues? recipeRequestStatues,
    RecipeRequestStatues? searchRequestStatues,
  }) {
    return RecipesState(
      errorMessage: errorMessage ?? this.errorMessage,
      recipesModel: recipesModel ?? this.recipesModel,
      searchModel: searchModel ?? this.searchModel,
      recipeRequestStatues: recipeRequestStatues ?? this.recipeRequestStatues,
      searchRequestStatues: searchRequestStatues ?? this.searchRequestStatues,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        recipesModel,
        searchModel,
        recipeRequestStatues,
        searchRequestStatues
      ];
}
