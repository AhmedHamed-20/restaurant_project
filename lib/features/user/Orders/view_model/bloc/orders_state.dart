part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final OrdersModel? myOrders;
  final String errorMessage;
  final OrdersRequestStatues ordersRequestStatues;

  const OrdersState(
      {this.myOrders,
      this.errorMessage = '',
      this.ordersRequestStatues = OrdersRequestStatues.loading});

  OrdersState copyWith({
    OrdersModel? myOrders,
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
