import 'package:equatable/equatable.dart';

import 'category_data_admin_recipe_model.dart';

class CategoryRecipeAdminModel extends Equatable {
  final int results;
  final List<CategoryAdminRecipeDataModel> categoryData;

  const CategoryRecipeAdminModel(
      {required this.results, required this.categoryData});
  factory CategoryRecipeAdminModel.fromJson(Map<String, dynamic> json) =>
      CategoryRecipeAdminModel(
        results: json['results'],
        categoryData: List<CategoryAdminRecipeDataModel>.from(json['data']
                ['data']
            .map((x) => CategoryAdminRecipeDataModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [results, categoryData];
}
