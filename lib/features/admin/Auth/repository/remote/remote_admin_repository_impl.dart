import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/admin/Auth/models/auth_admin_model.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/features/admin/Auth/repository/base/base_admin_auth_repositroy.dart';

class RemoteAutAdminRepositoryImpl extends BaseAdminAuthRepository {
  @override
  Future<Either<Failure, AuthAdminModel>> loginAdmin(
      LoginAdminParams params) async {
    try {
      final response = await DioHelper.postData(
          url: EndPoints.login,
          data: {'email': params.email, 'password': params.password});
      return Right(AuthAdminModel.fromJson(response?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }
}
