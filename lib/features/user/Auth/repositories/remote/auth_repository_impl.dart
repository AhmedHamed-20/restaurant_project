import 'package:dartz/dartz.dart';
import 'package:resturant/core/cache/chache_setup.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/core/network/network_service.dart';

import '../../models/auth_model.dart';
import '../base/base_auth_repository.dart';

class AuthRepositoryImpl extends BaseAuthRepository {
  final NetworkService _networkService;
  final CacheService _cacheService;
  AuthRepositoryImpl(this._networkService, this._cacheService);
  @override
  Future<Either<Failure, AuthModel>> login(LoginParams params) async {
    try {
      final response =
          await _networkService.postData(url: EndPoints.login, headers: {
        'Content-Type': 'application/json'
      }, data: {
        'email': params.email,
        'password': params.password,
      });

      return Right(AuthModel.fromJson(response.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signUp(SignUpParams params) async {
    try {
      final response =
          await _networkService.postData(url: EndPoints.signUp, headers: {
        'Content-Type': 'application/json'
      }, data: {
        'email': params.email,
        'name': params.name,
        'password': params.password,
        'passwordConfirm': params.passwordConfirmation,
      });

      return Right(AuthModel.fromJson(response.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(
      ForgetPasswordParams params) async {
    try {
      await _networkService.postData(url: EndPoints.forgetPassword, headers: {
        'Content-Type': 'application/json'
      }, data: {
        'email': params.email,
      });
      return const Right('Token sent to your email');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> cacheAccessToken(
      AccessTokenCacheParams params) async {
    try {
      await _cacheService.setData(
          key: 'accessToken', value: params.accessToken);
      return const Right('cached');
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
