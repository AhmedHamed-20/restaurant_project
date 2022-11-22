import 'package:equatable/equatable.dart';

import 'category_recipes_data_model.dart';

class CategoryRecipesModel extends Equatable {
  final int results;
  final List<CategoryRecipeDataModel> categoryRecipeDataModel;

  const CategoryRecipesModel(
      {required this.results, required this.categoryRecipeDataModel});

  factory CategoryRecipesModel.fromJson(Map<String, dynamic> json) {
    return CategoryRecipesModel(
      results: json['results'] as int,
      categoryRecipeDataModel: (json['data']['data'] as List<dynamic>)
          .map((e) =>
              CategoryRecipeDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  @override
  List<Object?> get props => [results, categoryRecipeDataModel];
}
