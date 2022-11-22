import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/layout/user/models/user_model.dart';

abstract class BaseLayoutRepository {
  Future<Either<Failure, UserModel>> getActiveUserData(ActiveUserParams params);
  Future<Either<Failure, UserModel>> updateUserData(
      UserDataUpdateParams params);
  Future<Either<Failure, String>> udpagetPassword(UpdatePasswordParams params);
  Future<Either<Failure, bool>> updateToken(UpdateTokenParams params);
  Future<Either<Failure, String>> getAccessToken(GetAccessTokenParams params);
  Future<Either<Failure, void>> clearCache(CacheClearParams params);
  Future<Either<Failure, int>> deleteFavoriteDataBase(
      FavoriteDatabaseDeleteParams params);
}

class ActiveUserParams extends Equatable {
  final String token;

  const ActiveUserParams(this.token);

  @override
  List<Object?> get props => [token];
}

class UserDataUpdateParams extends Equatable {
  final String token;
  final String name;
  final String email;

  const UserDataUpdateParams({
    required this.token,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [token, name, email];
}

class UpdatePasswordParams extends Equatable {
  final String token;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const UpdatePasswordParams({
    required this.token,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [token, oldPassword, newPassword, confirmPassword];
}

class UpdateTokenParams extends Equatable {
  final String token;
  final String key;

  const UpdateTokenParams({required this.token, required this.key});

  @override
  List<Object?> get props => [token, key];
}

class GetAccessTokenParams extends Equatable {
  final String key;

  const GetAccessTokenParams({required this.key});

  @override
  List<Object?> get props => [key];
}

class CacheClearParams extends Equatable {
  final String key;
  const CacheClearParams(this.key);

  @override
  List<Object?> get props => [key];
}

class FavoriteDatabaseDeleteParams extends Equatable {
  final String tableName;
  final String userId;

  const FavoriteDatabaseDeleteParams(
      {required this.tableName, required this.userId});

  @override
  List<Object?> get props => [tableName, userId];
}
