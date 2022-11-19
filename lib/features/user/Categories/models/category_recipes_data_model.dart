import 'package:equatable/equatable.dart';
import 'package:resturant/core/const/base_recipes_data_model.dart';

class CategoryRecipeDataModel extends BaseRecipesDataModel {
  const CategoryRecipeDataModel(
      {required super.ingredients,
      required super.name,
      required super.imageCover,
      required super.price,
      required super.category,
      required super.recipeId,
      required super.cookingTime,
      required super.slug});

  factory CategoryRecipeDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryRecipeDataModel(
      ingredients: json['ingredients'] as List<dynamic>,
      name: json['name'] as String,
      imageCover: json['imageCover'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
      recipeId: json['_id'] as String,
      cookingTime: json['cookingTime'] as int,
      slug: json['slug'] as String,
    );
  }
  @override
  List<Object?> get props => [
        ingredients,
        name,
        imageCover,
        price,
        category,
        recipeId,
        cookingTime,
        slug
      ];
}
