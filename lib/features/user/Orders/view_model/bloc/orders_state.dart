part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final List<OrdersModel> myOrders;
  final String errorMessage;
  final OrdersRequestStatues ordersRequestStatues;

  const OrdersState(
      {this.myOrders = const [],
      this.errorMessage = '',
      this.ordersRequestStatues = OrdersRequestStatues.loading});

  OrdersState copyWith({
    List<OrdersModel>? myOrders,
    String? errorMessage,
    OrdersRequestStatues? ordersRequestStatues,
  }) {
    return OrdersState(
      myOrders: myOrders ?? this.myOrders,
      errorMessage: errorMessage ?? this.errorMessage,
      ordersRequestStatues: ordersRequestStatues ?? this.ordersRequestStatues,
    );
  }

  @override
  List<Object?> get props => [myOrders, errorMessage, ordersRequestStatues];
}
