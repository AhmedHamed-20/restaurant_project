import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';

import '../../models/category_model.dart';
import '../../models/category_recipes_model.dart';

abstract class BaseCategoryRepository {
  Future<Either<Failure, CategoryModel>> getCategories();
  Future<Either<Failure, CategoryModel>> getMoreCategories(
      MoreCategoriesGetParams params);

  Future<Either<Failure, CategoryRecipesModel>> getCategoryRecipes(
      CategoryRecipesParams params);
  Future<Either<Failure, CategoryRecipesModel>> getMoreCategoryRecipes(
      MoreCategoryRecipesParams params);
}

class CategoryRecipesParams extends Equatable {
  final String categoryName;

  const CategoryRecipesParams({required this.categoryName});

  @override
  List<Object?> get props => [categoryName];
}

class MoreCategoriesGetParams extends Equatable {
  final String page;

  const MoreCategoriesGetParams(this.page);

  @override
  List<Object?> get props => [page];
}

class MoreCategoryRecipesParams extends Equatable {
  final String page;
  final String categoryName;

  const MoreCategoryRecipesParams(this.page, this.categoryName);

  @override
  List<Object?> get props => [page, categoryName];
}
