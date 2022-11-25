import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../models/category_model.dart';
import '../../models/category_recipes_model.dart';
import '../base/base_category_repository.dart';

class RemoteCategoryRepositoryImpl extends BaseCategoryRepository {
  @override
  Future<Either<Failure, CategoryModel>> getCategories() async {
    try {
      final respone =
          await DioHelper.getData(url: EndPoints.categories, headers: {
        'Content-Type': 'application/json',
      });
      return Right(CategoryModel.fromJson(respone?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, CategoryRecipesModel>> getCategoryRecipes(
      CategoryRecipesParams params) async {
    try {
      final response =
          await DioHelper.getData(url: EndPoints.allRecipies, headers: {
        'Content-Type': 'application/json',
      }, query: {
        'category': params.categoryName
      });
      return Right(CategoryRecipesModel.fromJson(response?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getMoreCategories(
      MoreCategoriesGetParams params) async {
    try {
      final respone = await DioHelper.getData(
          url: EndPoints.categoriesPage + params.page,
          headers: {
            'Content-Type': 'application/json',
          });
      return Right(CategoryModel.fromJson(respone?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, CategoryRecipesModel>> getMoreCategoryRecipes(
      MoreCategoryRecipesParams params) async {
    try {
      final response =
          await DioHelper.getData(url: EndPoints.categories, query: {
        'category': params.categoryName,
        'page': params.page,
      }, headers: {
        'Content-Type': 'application/json',
      });
      return Right(CategoryRecipesModel.fromJson(response?.data));
    } on DioError catch (e) {
      return Left(e.response?.data['message']);
    }
  }
}
