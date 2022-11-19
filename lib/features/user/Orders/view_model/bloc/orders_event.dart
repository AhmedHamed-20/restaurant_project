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
