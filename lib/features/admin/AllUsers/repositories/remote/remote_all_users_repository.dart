import 'package:dartz/dartz.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/core/network/network_service.dart';
import 'package:resturant/features/admin/AllUsers/models/all_users_model.dart';
import 'package:resturant/features/admin/AllUsers/repositories/base/base_all_users_repository.dart';

class RemoteAllUserRepositoryImpl extends BaseAllUsersRepository {
  final NetworkService _networkService;

  RemoteAllUserRepositoryImpl(this._networkService);
  @override
  Future<Either<Failure, AllUsersModel>> getAllUsers(
      AllUsersGetParams params) async {
    try {
      final respone =
          await _networkService.getData(url: EndPoints.allusers, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.adminToken}',
      }, query: {
        'page': params.page,
      });
      return Right(AllUsersModel.fromJson(respone.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUserById(
      DeleteUserByIdParams params) async {
    try {
      await _networkService
          .deleteData(url: EndPoints.allusers + params.userId, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.adminToken}',
      });
      return const Right('Deleted successfully');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> udpateUserDataById(
      UpdateUserDataByIdParams params) async {
    try {
      await _networkService
          .patchData(url: EndPoints.allusers + params.userId, data: {
        'name': params.name,
        'email': params.email,
        'role': params.role
      }, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.adminToken}',
      });
      return const Right('Updated Successfully');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
