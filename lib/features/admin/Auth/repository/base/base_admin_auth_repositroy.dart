import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/Auth/models/auth_admin_model.dart';

import '../../../../../core/error/failure.dart';

abstract class BaseAdminAuthRepository {
  Future<Either<Failure, AuthAdminModel>> loginAdmin(LoginAdminParams params);
}

class LoginAdminParams extends Equatable {
  final String email;
  final String password;

  const LoginAdminParams(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
