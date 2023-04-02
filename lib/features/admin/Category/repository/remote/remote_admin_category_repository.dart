import 'package:dartz/dartz.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/admin/Category/models/admin_category_model.dart';

import '../../../../../core/network/network_service.dart';
import '../base/base_admin_category_repository.dart';

class RemoteAdminCategoryRepository extends BaseAdminCategoryRepository {
  final NetworkService _networkService;

  RemoteAdminCategoryRepository(this._networkService);
  @override
  Future<Either<Failure, String>> addCategory(
      CategoryAdminAddParams params) async {
    try {
      final response = await _networkService.postData(
        url: EndPoints.categories,
        data: {
          'name': params.name,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return Right(response.data['message'] ?? 'added successfully');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCategory(
      CategoryAdminDeleteParams params) async {
    try {
      await _networkService.deleteData(
        url: EndPoints.categories + params.id,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return const Right('deleted successfully');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, AdminCategoryModel>> getCategories() async {
    try {
      final response = await _networkService.getData(
        url: EndPoints.categories,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return Right(AdminCategoryModel.fromJson(response.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> updateCategory(
      CategoryAdminUpdateParams params) async {
    try {
      final response = await _networkService.patchData(
        url: EndPoints.categories + params.id,
        data: {
          'name': params.name,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.adminToken}',
        },
      );
      return Right(response?.data['message'] ?? 'updated successfully');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
