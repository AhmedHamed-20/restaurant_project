import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/admin/Orders/models/orders_model.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/features/admin/Orders/repository/base/base_admin_orders_repository.dart';

class RemoteAdminOrdersRepositoryImpl extends BaseAdminOrdersRepository {
  @override
  Future<Either<Failure, String>> cancelOrder(
      AdminOrdersCancleParams params) async {
    try {
      final response = await DioHelper.deleteData(
          url: EndPoints.deleteOrder + params.orderId,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${params.adminToken}',
          });
      return const Right('Deleted Success');
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response!.data['message']));
    }
  }

  @override
  Future<Either<Failure, OrdersAdminModel>> getAllOrders(
      AdminOrdersGetParams params) async {
    try {
      final resposne =
          await DioHelper.getData(url: EndPoints.allOrders, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.adminToken}',
      });
      return Right(OrdersAdminModel.fromJson(resposne?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.response!.data['message']));
    }
  }
}
