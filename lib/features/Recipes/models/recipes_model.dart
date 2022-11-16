import 'package:equatable/equatable.dart';
import 'package:resturant/features/Recipes/models/recipe_data_model.dart';

class RecipesModel extends Equatable {
  final int results;
  final List<RecipeDataModel> recipeDataModel;

  const RecipesModel({required this.results, required this.recipeDataModel});

  factory RecipesModel.fromJson(Map<String, dynamic> json) {
    return RecipesModel(
      results: json['results'] as int,
      recipeDataModel: (json['data']['data'] as List<dynamic>)
          .map((e) => RecipeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [results, recipeDataModel];
}
