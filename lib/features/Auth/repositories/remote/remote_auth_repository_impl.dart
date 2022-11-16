import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/Auth/models/auth_model.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/features/Auth/repositories/base/base_auth_repository.dart';

class RemoteAuthRepositoryImpl extends BaseAuthRepository {
  @override
  Future<Either<Failure, AuthModel>> login(LoginParams params) async {
    try {
      final response = await DioHelper.postData(url: EndPoints.login, headers: {
        'Content-Type': 'application/json'
      }, data: {
        'email': params.email,
        'password': params.password,
      });

      return Right(AuthModel.fromJson(response!.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signUp(SignUpParams params) async {
    try {
      final response =
          await DioHelper.postData(url: EndPoints.signUp, headers: {
        'Content-Type': 'application/json'
      }, data: {
        'email': params.email,
        'name': params.name,
        'password': params.password,
        'passwordConfirm': params.passwordConfirmation,
      });

      return Right(AuthModel.fromJson(response!.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      await DioHelper.postData(url: EndPoints.forgetPassword, headers: {
        'Content-Type': 'application/json'
      }, data: {
        'email': params.email,
      });
      return const Right('Token sent to your email');
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    }
  }
}
