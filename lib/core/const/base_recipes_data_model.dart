import 'package:equatable/equatable.dart';

abstract class BaseRecipesDataModel extends Equatable {
  final List<dynamic> ingredients;
  final String name;
  final String imageCover;
  final int price;
  final String category;
  final String recipeId;
  final int cookingTime;
  final String slug;

  const BaseRecipesDataModel(
      {required this.ingredients,
      required this.name,
      required this.imageCover,
      required this.price,
      required this.category,
      required this.recipeId,
      required this.cookingTime,
      required this.slug});
}
