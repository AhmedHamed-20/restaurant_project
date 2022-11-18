import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';

import '../../models/auth_model.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, AuthModel>> login(LoginParams params);
  Future<Either<Failure, AuthModel>> signUp(SignUpParams params);
  Future<Either<Failure, String>> forgetPassword(ForgetPasswordParams params);
  Future<Either<Failure, String>> cacheAccessToken(
      AccessTokenCacheParams params);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpParams extends Equatable {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  const SignUpParams(
      {required this.email,
      required this.password,
      required this.name,
      required this.passwordConfirmation});

  @override
  List<Object?> get props => [email, password, name, passwordConfirmation];
}

class ForgetPasswordParams extends Equatable {
  final String email;

  const ForgetPasswordParams(this.email);

  @override
  List<Object?> get props => [email];
}

class AccessTokenCacheParams extends Equatable {
  final String accessToken;

  const AccessTokenCacheParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
