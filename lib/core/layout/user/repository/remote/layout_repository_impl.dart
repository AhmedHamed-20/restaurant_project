import 'package:dartz/dartz.dart';
import 'package:resturant/core/cache/chache_setup.dart';
import 'package:resturant/core/database/date_base_service.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/layout/user/models/user_model.dart';
import 'package:resturant/core/layout/user/repository/base/layout_base_repository.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/core/network/network_service.dart';

class LayoutRepositoryImpl extends BaseLayoutRepository {
  final NetworkService _networkService;
  final DataBaseService _dataBaseService;
  final CacheService _cacheService;
  LayoutRepositoryImpl(
      this._networkService, this._dataBaseService, this._cacheService);
  @override
  Future<Either<Failure, UserModel>> getActiveUserData(
      ActiveUserParams params) async {
    try {
      final respone = await _networkService.getData(
        url: EndPoints.getMe,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${params.token}',
        },
      );
      return Right(UserModel.fromJson(respone.data['data']['data']));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserData(
      UserDataUpdateParams params) async {
    try {
      final resposne = await _networkService.patchData(
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
      return Right(UserModel.fromJson(resposne?.data['user']));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> udpagetPassword(
      UpdatePasswordParams params) async {
    try {
      final response =
          await _networkService.patchData(url: EndPoints.updatePassword, data: {
        'passwordCurrent': params.oldPassword,
        'password': params.newPassword,
        'passwordConfirm': params.confirmPassword
      }, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });

      return Right(response?.data['token']);
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateToken(UpdateTokenParams params) async {
    try {
      final result =
          await _cacheService.setData(key: params.key, value: params.token);
      return Right(result);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken(
      GetAccessTokenParams params) async {
    try {
      final result = await _cacheService.getData(key: params.key);
      return Right(result);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCache(CacheClearParams params) async {
    try {
      await _cacheService.removeData(params.key);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteFavoriteDataBase(
      FavoriteDatabaseDeleteParams params) async {
    try {
      final result = await _dataBaseService.deleteAllDataFromDatabaseByUserId(
          tableName: params.tableName, userId: params.userId);
      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
