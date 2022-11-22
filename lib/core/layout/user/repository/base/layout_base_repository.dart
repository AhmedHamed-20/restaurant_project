import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/layout/user/models/user_model.dart';

abstract class BaseLayoutRepository {
  Future<Either<Failure, UserModel>> getActiveUserData(ActiveUserParams params);
  Future<Either<Failure, UserModel>> updateUserData(
      UserDataUpdateParams params);
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
