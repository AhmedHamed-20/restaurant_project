import 'package:equatable/equatable.dart';
import 'package:resturant/features/Recipes/models/recipe_data_model.dart';

class CategoryRecipesModel extends Equatable {
  final int results;
  final List<RecipeDataModel> recipeDataModel;

  const CategoryRecipesModel(
      {required this.results, required this.recipeDataModel});

  factory CategoryRecipesModel.fromJson(Map<String, dynamic> json) {
    return CategoryRecipesModel(
      results: json['results'] as int,
      recipeDataModel: (json['data']['data'] as List<dynamic>)
          .map((e) => RecipeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [results, recipeDataModel];
}
