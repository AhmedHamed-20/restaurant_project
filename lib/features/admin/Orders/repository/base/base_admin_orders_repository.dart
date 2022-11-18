import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';
import 'package:resturant/features/admin/Orders/models/orders_model.dart';

abstract class BaseAdminOrdersRepository {
  Future<Either<Failure, OrdersAdminModel>> getAllOrders(
      AdminOrdersGetParams params);
  Future<Either<Failure, String>> cancelOrder(AdminOrdersCancleParams params);
}

class AdminOrdersGetParams extends Equatable {
  final String adminToken;

  const AdminOrdersGetParams({required this.adminToken});

  @override
  List<Object?> get props => [adminToken];
}

class AdminOrdersCancleParams extends Equatable {
  final String adminToken;
  final String orderId;
  const AdminOrdersCancleParams(
      {required this.adminToken, required this.orderId});

  @override
  List<Object?> get props => [adminToken, orderId];
}
