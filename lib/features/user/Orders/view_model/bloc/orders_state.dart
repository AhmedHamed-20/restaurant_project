part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final List<OrdersModel> myOrders;
  final String errorMessage;
  final OrdersRequestStatues ordersRequestStatues;
  final bool isOrderedSuccessfully;
  const OrdersState(
      {this.myOrders = const [],
      this.errorMessage = '',
      this.isOrderedSuccessfully = false,
      this.ordersRequestStatues = OrdersRequestStatues.loading});

  OrdersState copyWith({
    bool? isOrderedSuccessfully,
    List<OrdersModel>? myOrders,
    String? errorMessage,
    OrdersRequestStatues? ordersRequestStatues,
  }) {
    return OrdersState(
      isOrderedSuccessfully:
          isOrderedSuccessfully ?? this.isOrderedSuccessfully,
      myOrders: myOrders ?? this.myOrders,
      errorMessage: errorMessage ?? this.errorMessage,
      ordersRequestStatues: ordersRequestStatues ?? this.ordersRequestStatues,
    );
  }

  @override
  List<Object?> get props =>
      [myOrders, errorMessage, isOrderedSuccessfully, ordersRequestStatues];
}
