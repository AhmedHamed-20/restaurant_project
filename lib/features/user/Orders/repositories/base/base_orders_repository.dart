import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/error/failure.dart';

import '../../models/orders_model.dart';

abstract class BaseOrderRepository {
  Future<Either<Failure, List<OrdersModel>>> getMyOrders(MyOrderParams params);
  Future<Either<Failure, bool>> orderRecipe(OrderRecipeParams params);
}

class MyOrderParams extends Equatable {
  final String token;

  const MyOrderParams({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}

class OrderRecipeParams extends Equatable {
  final String token;
  final List<Map<String, dynamic>> orderContent;
  final String address;
  final String phoneNumber;

  const OrderRecipeParams(
      {required this.token,
      required this.orderContent,
      required this.address,
      required this.phoneNumber});

  @override
  List<Object?> get props => [token, orderContent, address, phoneNumber];
}
