import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/features/admin/AllUsers/models/all_users_model.dart';

abstract class BaseAllUsersRepository {
  Future<Either<Failure, AllUsersModel>> getAllUsers(AllUsersGetParams params);
  Future<Either<Failure, String>> deleteUserById(DeleteUserByIdParams params);
  Future<Either<Failure, String>> udpateUserDataById(
      UpdateUserDataByIdParams params);

  Future<Either<Failure, AllUsersModel>> getMoreUsers(
      MoreUsersGetParams params);
}

class AllUsersGetParams extends Equatable {
  final String adminToken;

  const AllUsersGetParams({required this.adminToken});

  @override
  List<Object?> get props => [adminToken];
}

class DeleteUserByIdParams extends Equatable {
  final String adminToken;
  final String userId;

  const DeleteUserByIdParams({
    required this.adminToken,
    required this.userId,
  });

  @override
  List<Object?> get props => [adminToken, userId];
}

class UpdateUserDataByIdParams extends Equatable {
  final String userId;
  final String adminToken;
  final String name;
  final String email;
  final String role;

  const UpdateUserDataByIdParams(
      {required this.adminToken,
      required this.name,
      required this.userId,
      required this.email,
      required this.role});

  @override
  List<Object?> get props => [adminToken, name, email, role, userId];
}

class MoreUsersGetParams extends Equatable {
  final String adminToken;
  final String page;

  const MoreUsersGetParams({
    required this.adminToken,
    required this.page,
  });

  @override
  List<Object?> get props => [adminToken, page];
}
