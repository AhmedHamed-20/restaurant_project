import 'package:dio/dio.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/network/endpoints.dart';
import 'package:resturant/features/Orders/models/orders_model.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:resturant/features/Orders/repositories/base/base_orders_repository.dart';

class RemoteOrdersRepository extends BaseOrderRepository {
  @override
  Future<Either<Failure, OrdersModel>> getMyOrders(MyOrderParams params) async {
    try {
      final respone = await DioHelper.getData(url: EndPoints.myOrder, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });
      return Right(OrdersModel.fromJson(respone?.data));
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> orderRecipe(OrderRecipeParams params) async {
    try {
      final respone = await DioHelper.postData(url: EndPoints.myOrder, data: {
        "orderContent": params.orderContent,
        "customerAddress": params.address,
        "customerPhoneNumber": params.phoneNumber,
      }, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${params.token}',
      });
      return Right(respone?.data);
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
