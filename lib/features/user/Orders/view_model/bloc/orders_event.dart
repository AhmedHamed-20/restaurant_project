part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class MyOrdersEvent extends OrdersEvent {
  final String token;

  const MyOrdersEvent({required this.token});

  @override
  List<Object?> get props => [token];
}

class OrderRecipeEvent extends OrdersEvent {
  final String token;
  final List<Map<String, dynamic>> orderContent;
  final String address;
  final String phoneNumber;

  const OrderRecipeEvent(
      {required this.token,
      required this.orderContent,
      required this.address,
      required this.phoneNumber});

  @override
  List<Object?> get props => [token, orderContent, address, phoneNumber];
}

class OrderResetBoolEvent extends OrdersEvent {
  const OrderResetBoolEvent();

  @override
  List<Object?> get props => [];
}

class MoreMyOrdersGetEvent extends OrdersEvent {
  final String token;
  final String page;

  const MoreMyOrdersGetEvent({required this.token, required this.page});

  @override
  List<Object?> get props => [token, page];
}

class OrderCancelEvent extends OrdersEvent {
  final String token;
  final String orderId;

  const OrderCancelEvent({required this.token, required this.orderId});

  @override
  List<Object?> get props => [token, orderId];
}
