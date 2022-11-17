import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/AllRecipes/models/recipe_data_admin_model.dart';

class RecipesAdminModel extends Equatable {
  final int results;
  final List<RecipeAdminDataModel> recipeDataModel;

  const RecipesAdminModel(
      {required this.results, required this.recipeDataModel});

  factory RecipesAdminModel.fromJson(Map<String, dynamic> json) {
    return RecipesAdminModel(
      results: json['results'] as int,
      recipeDataModel: (json['data']['data'] as List<dynamic>)
          .map((e) => RecipeAdminDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [results, recipeDataModel];
}
