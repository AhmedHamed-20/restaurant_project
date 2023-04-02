part of 'recipes_bloc.dart';

class RecipesState extends Equatable {
  final String errorMessage;
  final RecipesModel? recipesModel;
  final RecipesModel? searchModel;
  final RecipeRequestStatues recipeRequestStatues;
  final RecipeRequestStatues moreRecipesGetRequestStatues;
  final RecipeRequestStatues searchRequestStatues;
  final List<FavoriteModel> favouriteModel;
  final RecipeRequestStatues favouriteRequestStatues;
  final Map<String, int>? amount;
  final bool inFavoritesDatabase;
  final List<CartModel> cartModel;
  final bool addedToCart;
  final bool isEndOfData;
  const RecipesState(
      {this.errorMessage = '',
      this.recipesModel,
      this.searchModel,
      this.moreRecipesGetRequestStatues = RecipeRequestStatues.loading,
      this.isEndOfData = false,
      this.addedToCart = false,
      this.cartModel = const [],
      this.inFavoritesDatabase = false,
      this.amount,
      this.favouriteModel = const [],
      this.favouriteRequestStatues = RecipeRequestStatues.loading,
      this.recipeRequestStatues = RecipeRequestStatues.loading,
      this.searchRequestStatues = RecipeRequestStatues.loading});

  RecipesState copyWith({
    bool? isEndOfData,
    RecipeRequestStatues? moreRecipesGetRequestStatues,
    List<CartModel>? cartModel,
    bool? inFavoritesDatabase,
    List<FavoriteModel>? favouriteModel,
    RecipeRequestStatues? favouriteRequestStatues,
    String? errorMessage,
    Map<String, int>? amount,
    RecipesModel? recipesModel,
    bool? addedToCart,
    RecipesModel? searchModel,
    RecipeRequestStatues? recipeRequestStatues,
    RecipeRequestStatues? searchRequestStatues,
  }) {
    return RecipesState(
      isEndOfData: isEndOfData ?? this.isEndOfData,
      moreRecipesGetRequestStatues:
          moreRecipesGetRequestStatues ?? this.moreRecipesGetRequestStatues,
      addedToCart: addedToCart ?? this.addedToCart,
      cartModel: cartModel ?? this.cartModel,
      inFavoritesDatabase: inFavoritesDatabase ?? this.inFavoritesDatabase,
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
        cartModel,
        addedToCart,
        isEndOfData,
        searchModel,
        inFavoritesDatabase,
        recipeRequestStatues,
        searchRequestStatues,
        moreRecipesGetRequestStatues,
        identityHashCode(this)
      ];
}
