part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  final List<OrdersModel> myOrders;
  final String errorMessage;
  final OrdersRequestStatues ordersRequestStatues;
  final OrdersRequestStatues ordersMoreRequestStatues;
  final MyOrderCancelRequestStatues myOrderCancelRequestStatues;
  final bool isOrderedSuccessfully;
  final bool isEndOfData;
  const OrdersState(
      {this.myOrders = const [],
      this.isEndOfData = false,
      this.myOrderCancelRequestStatues = MyOrderCancelRequestStatues.idle,
      this.ordersMoreRequestStatues = OrdersRequestStatues.loading,
      this.errorMessage = '',
      this.isOrderedSuccessfully = false,
      this.ordersRequestStatues = OrdersRequestStatues.loading});

  OrdersState copyWith({
    MyOrderCancelRequestStatues? myOrderCancelRequestStatues,
    bool? isEndOfData,
    OrdersRequestStatues? ordersMoreRequestStatues,
    bool? isOrderedSuccessfully,
    List<OrdersModel>? myOrders,
    String? errorMessage,
    OrdersRequestStatues? ordersRequestStatues,
  }) {
    return OrdersState(
      myOrderCancelRequestStatues:
          myOrderCancelRequestStatues ?? this.myOrderCancelRequestStatues,
      isEndOfData: isEndOfData ?? this.isEndOfData,
      ordersMoreRequestStatues:
          ordersMoreRequestStatues ?? this.ordersMoreRequestStatues,
      isOrderedSuccessfully:
          isOrderedSuccessfully ?? this.isOrderedSuccessfully,
      myOrders: myOrders ?? this.myOrders,
      errorMessage: errorMessage ?? this.errorMessage,
      ordersRequestStatues: ordersRequestStatues ?? this.ordersRequestStatues,
    );
  }

  @override
  List<Object?> get props => [
        myOrders,
        myOrderCancelRequestStatues,
        errorMessage,
        isOrderedSuccessfully,
        ordersRequestStatues,
        isEndOfData,
        ordersMoreRequestStatues,
      ];
}
