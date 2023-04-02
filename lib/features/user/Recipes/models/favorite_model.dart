import 'dart:convert';

import 'package:resturant/core/const/base_recipes_data_model.dart';

class FavoriteModel extends BaseRecipesDataModel {
  final int databaseId;

  const FavoriteModel(
      {required super.ingredients,
      required this.databaseId,
      required super.name,
      required super.imageCover,
      required super.price,
      required super.category,
      required super.recipeId,
      required super.cookingTime,
      required super.slug});

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      databaseId: map['id'],
      ingredients: json.decode(map['ingredients']) as List<dynamic>,
      name: map['name'] as String,
      imageCover: map['imageCover'] as String,
      price: map['price'] as int,
      category: map['category'] as String,
      recipeId: map['recipeId'] as String,
      cookingTime: map['cookingTime'] as int,
      slug: map['slug'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ingredients': json.encode(ingredients),
      'name': name,
      'imageCover': imageCover,
      'price': price,
      'category': category,
      'recipeId': recipeId,
      'cookingTime': cookingTime,
      'slug': slug,
    };
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
        slug,
        databaseId
      ];
}
