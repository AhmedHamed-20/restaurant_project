import 'dart:convert';

import 'package:equatable/equatable.dart';

class FavouriteModel extends Equatable {
  final int databaseId;
  final List<String> ingredients;
  final String name;
  final String imageCover;
  final int price;
  final String category;
  final String recipeId;
  final int cookingTime;
  final String slug;

  const FavouriteModel(
      {required this.ingredients,
      required this.databaseId,
      required this.name,
      required this.imageCover,
      required this.price,
      required this.category,
      required this.recipeId,
      required this.cookingTime,
      required this.slug});

  factory FavouriteModel.fromMap(Map<String, dynamic> map) {
    return FavouriteModel(
      databaseId: map['id'],
      ingredients: json.decode(map['ingredients']) as List<String>,
      name: map['name'] as String,
      imageCover: map['imageCover'] as String,
      price: map['price'] as int,
      category: map['category'] as String,
      recipeId: map['_id'] as String,
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
      'id': recipeId,
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
