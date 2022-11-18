part of 'recipes_bloc.dart';

class RecipesState extends Equatable {
  final String errorMessage;
  final RecipesModel? recipesModel;
  final RecipesModel? searchModel;
  final RecipeRequestStatues recipeRequestStatues;
  final RecipeRequestStatues searchRequestStatues;
  final List<FavouriteModel> favouriteModel;
  final RecipeRequestStatues favouriteRequestStatues;
  final Map<String, int>? amount;
  const RecipesState(
      {this.errorMessage = '',
      this.recipesModel,
      this.searchModel,
      this.amount,
      this.favouriteModel = const [],
      this.favouriteRequestStatues = RecipeRequestStatues.loading,
      this.recipeRequestStatues = RecipeRequestStatues.loading,
      this.searchRequestStatues = RecipeRequestStatues.loading});

  RecipesState copyWith({
    List<FavouriteModel>? favouriteModel,
    RecipeRequestStatues? favouriteRequestStatues,
    String? errorMessage,
    Map<String, int>? amount,
    RecipesModel? recipesModel,
    RecipesModel? searchModel,
    RecipeRequestStatues? recipeRequestStatues,
    RecipeRequestStatues? searchRequestStatues,
  }) {
    return RecipesState(
      amount: amount ?? this.amount,
      favouriteModel: favouriteModel ?? this.favouriteModel,
      favouriteRequestStatues:
          favouriteRequestStatues ?? this.favouriteRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
      recipesModel: recipesModel ?? this.recipesModel,
      searchModel: searchModel ?? this.searchModel,
      recipeRequestStatues: recipeRequestStatues ?? this.recipeRequestStatues,
      searchRequestStatues: searchRequestStatues ?? this.searchRequestStatues,
    );
  }

  @override
  List<Object?> get props => [
        favouriteModel,
        favouriteRequestStatues,
        errorMessage,
        recipesModel,
        amount,
        searchModel,
        recipeRequestStatues,
        searchRequestStatues
      ];
}
