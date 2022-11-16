import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/features/Categories/models/category_model.dart';
import 'package:resturant/features/Categories/models/category_recipes_model.dart';

abstract class BaseCategoryRepository {
  Future<Either<Failure, CategoryModel>> getCategories();
  Future<Either<Failure, CategoryRecipesModel>> getCategoryRecipes(
      CategoryRecipesParams params);
}

class CategoryRecipesParams extends Equatable {
  final String categoryName;

  const CategoryRecipesParams({required this.categoryName});

  @override
  List<Object?> get props => [categoryName];
}
