import 'package:dio/dio.dart';
import 'package:resturant/core/layout/models/user_model.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/core/layout/repository/base/layout_base_repository.dart';
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
}
