import 'package:equatable/equatable.dart';

class CategoryRecipeDataModel extends Equatable {
  final List<String> ingredients;
  final String name;
  final String imageCover;
  final int price;
  final String category;
  final String id;
  final int cookingTime;
  final String slug;

  const CategoryRecipeDataModel(
      {required this.ingredients,
      required this.name,
      required this.imageCover,
      required this.price,
      required this.category,
      required this.id,
      required this.cookingTime,
      required this.slug});

  factory CategoryRecipeDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryRecipeDataModel(
      ingredients: json['ingredients'] as List<String>,
      name: json['name'] as String,
      imageCover: json['imageCover'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
      id: json['_id'] as String,
      cookingTime: json['cookingTime'] as int,
      slug: json['slug'] as String,
    );
  }
  @override
  List<Object?> get props =>
      [ingredients, name, imageCover, price, category, id, cookingTime, slug];
}
