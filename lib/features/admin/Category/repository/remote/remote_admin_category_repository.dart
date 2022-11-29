import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/admin/Category/models/admin_category_model.dart';

import 'package:resturant/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../base/base_admin_category_repository.dart';

class RemoteAdminCategoryRepository extends BaseAdminCategoryRepository {
  @override
  Future<Either<Failure, String>> addCategory(
      CategoryAdminAddParams params) async {
    try {
      final response = await DioHelper.postData(
        url: EndPoints.categories,
        data: {
          'name': params.name,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return Right(response?.data['message'] ?? 'added successfully');
    } on DioError catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'error'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCategory(
      CategoryAdminDeleteParams params) async {
    try {
      final response = await DioHelper.deleteData(
        url: EndPoints.categories + params.id,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return Right(response?.data['message'] ?? 'deleted successfully');
    } on DioError catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'error'));
    }
  }

  @override
  Future<Either<Failure, AdminCategoryModel>> getCategories() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.categories,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return Right(AdminCategoryModel.fromJson(response?.data));
    } on DioError catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'error'));
    }
  }

  @override
  Future<Either<Failure, String>> updateCategory(
      CategoryAdminUpdateParams params) async {
    try {
      final response = await DioHelper.patchData(
        url: EndPoints.categories + params.id,
        data: {
          'name': params.name,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return Right(response?.data['message'] ?? 'updated successfully');
    } on DioError catch (e) {
      return Left(
          ServerFailure(message: e.response?.data['message'] ?? 'error'));
    }
  }
}
