import 'package:dartz/dartz.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/core/network/endpoints.dart';

import '../../../../../core/network/network_service.dart';
import '../../models/orders_model.dart';
import '../base/base_orders_repository.dart';

class RemoteOrdersRepository extends BaseOrderRepository {
  final NetworkService _networkService;

  RemoteOrdersRepository(this._networkService);
  @override
  Future<Either<Failure, List<OrdersModel>>> getMyOrders(
      MyOrderParams params) async {
    try {
      final resposne =
          await _networkService.getData(url: EndPoints.myOrder, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });
      return Right(List.from(resposne.data['data'])
          .map((e) => OrdersModel.fromJson(e))
          .toList());
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> orderRecipe(OrderRecipeParams params) async {
    try {
      await _networkService.postData(url: EndPoints.myOrder, data: {
        "orderContent": params.orderContent,
        "customerAddress": params.address,
        "customerPhoneNumber": params.phoneNumber,
      }, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });
      return const Right(true);
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<OrdersModel>>> getMoreMyOrders(params) async {
    try {
      final resposne = await _networkService
          .getData(url: EndPoints.myOrderPage + params.page, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });
      return Right(List.from(resposne.data['data'])
          .map((e) => OrdersModel.fromJson(e))
          .toList());
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> cancelOrder(CancelOrderParams params) async {
    try {
      final response = await _networkService
          .deleteData(url: EndPoints.cancelOrder + params.orderId, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });
      return Right(response?.data['message'] ?? 'success');
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
