import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/features/admin/AllUsers/models/all_users_model.dart';

abstract class BaseAllUsersRepository {
  Future<Either<Failure, AllUsersModel>> getAllUsers(AllUsersGetParams params);
}

class AllUsersGetParams extends Equatable {
  final String adminToken;

  const AllUsersGetParams({required this.adminToken});

  @override
  List<Object?> get props => [adminToken];
}
