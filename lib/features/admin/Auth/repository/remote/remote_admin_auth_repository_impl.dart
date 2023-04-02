import 'package:dartz/dartz.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/admin/Auth/models/auth_admin_model.dart';
import 'package:resturant/features/admin/Auth/repository/base/base_admin_auth_repositroy.dart';

import '../../../../../core/network/network_service.dart';

class RemoteAuthAdminRepositoryImpl extends BaseAdminAuthRepository {
  final NetworkService _networkService;

  RemoteAuthAdminRepositoryImpl(this._networkService);
  @override
  Future<Either<Failure, AuthAdminModel>> loginAdmin(
      LoginAdminParams params) async {
    try {
      final response = await _networkService.postData(
          url: EndPoints.login,
          data: {'email': params.email, 'password': params.password});
      return Right(AuthAdminModel.fromJson(response.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
