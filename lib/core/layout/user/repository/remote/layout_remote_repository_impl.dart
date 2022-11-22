import 'package:dio/dio.dart';
import 'package:resturant/core/layout/user/models/user_model.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/core/layout/user/repository/base/layout_base_repository.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';

class LayoutRemoteRepositoryImpl extends BaseLayoutRepository {
  @override
  Future<Either<Failure, UserModel>> getActiveUserData(
      ActiveUserParams params) async {
    try {
      final respone = await DioHelper.getData(
        url: EndPoints.getMe,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.token}',
        },
      );
      return Right(UserModel.fromJson(respone?.data['data']['data']));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserData(
      UserDataUpdateParams params) async {
    try {
      final resposne = await DioHelper.patchData(
        url: EndPoints.updateMe,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.token}',
        },
        data: {
          'name': params.name,
          'email': params.email,
        },
      );
      print(resposne);
      return Right(UserModel.fromJson(resposne?.data['user']));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
