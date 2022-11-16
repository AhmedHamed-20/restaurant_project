import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/layout/models/user_model.dart';

abstract class BaseLayoutRepository {
  Future<Either<Failure, UserModel>> getActiveUserData(ActiveUserParams params);
}

class ActiveUserParams extends Equatable {
  final String token;

  const ActiveUserParams(this.token);

  @override
  List<Object?> get props => [token];
}
