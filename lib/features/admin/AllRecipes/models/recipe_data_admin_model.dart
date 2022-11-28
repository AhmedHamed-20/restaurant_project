import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';

class RecipeAdminDataModel extends Equatable {
  final List<dynamic> ingredients;
  final String name;
  final String imageCover;
  final int price;
  final String category;
  final String id;
  final int cookingTime;
  final String slug;

  const RecipeAdminDataModel(
      {required this.ingredients,
      required this.name,
      required this.imageCover,
      required this.price,
      required this.category,
      required this.id,
      required this.cookingTime,
      required this.slug});

  factory RecipeAdminDataModel.fromJson(Map<String, dynamic> json) {
    return RecipeAdminDataModel(
      ingredients: json['ingredients'] as List<dynamic>,
      name: json['name'] as String,
      imageCover: json['imageCover'] as String,
      price: json['price'] as int,
      category: json['category'] as String,
      id: json['_id'] as String,
      cookingTime: json['cookingTime'] as int,
      slug: json['slug'] as String,
    );
  }
  Future<Map<String, dynamic>> toMapWithImage(String imagePath) async {
    final imageName = imagePath.split('/').last;
    return {
      'ingredients': ingredients,
      'name': name,
      'imageCover': await MultipartFile.fromFile(imagePath,
          filename: imageName, contentType: MediaType('image', 'png')),
      'price': price,
      'category': category,
      'cookingTime': cookingTime,
    };
  }

  Map<String, dynamic> toMapWithoutImage() {
    return {
      'ingredients': ingredients,
      'name': name,
      'price': price,
      'category': category,
      'cookingTime': cookingTime,
    };
  }

  @override
  List<Object?> get props =>
      [ingredients, name, imageCover, price, category, id, cookingTime, slug];
}
