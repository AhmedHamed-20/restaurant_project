import 'package:dartz/dartz.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/core/network/network_service.dart';
import 'package:resturant/features/admin/Orders/models/orders_model.dart';
import 'package:resturant/features/admin/Orders/repository/base/base_admin_orders_repository.dart';

class RemoteAdminOrdersRepositoryImpl extends BaseAdminOrdersRepository {
  final NetworkService _networkService;

  RemoteAdminOrdersRepositoryImpl(this._networkService);
  @override
  Future<Either<Failure, String>> cancelOrder(
      AdminOrdersCancleParams params) async {
    try {
      await _networkService
          .deleteData(url: EndPoints.deleteOrder + params.orderId, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.adminToken}',
      });
      return const Right('Deleted Success');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, OrdersAdminModel>> getAllOrders(
      AdminOrdersGetParams params) async {
    try {
      final resposne =
          await _networkService.getData(url: EndPoints.allOrders, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.adminToken}',
      }, query: {
        'page': params.page
      });
      return Right(OrdersAdminModel.fromJson(resposne.data));
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
