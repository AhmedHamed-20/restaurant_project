// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'orders_admin_bloc.dart';

class OrdersAdminState extends Equatable {
  final String errorMessage;
  final OrdersAdminModel? ordersAdminModel;
  final OrdersAdminRequestStatues ordersAdminRequestStatues;
  final OrdersAdminRequestStatues ordersAdminGetMoreRequestStatues;

  final OrdersAdminRequestStatues ordersAdminDeleteRequestStatues;
  final bool isEndOfData;
  const OrdersAdminState(
      {this.errorMessage = '',
      this.ordersAdminModel,
      this.ordersAdminGetMoreRequestStatues = OrdersAdminRequestStatues.loading,
      this.isEndOfData = false,
      this.ordersAdminDeleteRequestStatues = OrdersAdminRequestStatues.loading,
      this.ordersAdminRequestStatues = OrdersAdminRequestStatues.loading});

  OrdersAdminState copyWith({
    OrdersAdminRequestStatues? ordersAdminGetMoreRequestStatues,
    bool? isEndOfData,
    OrdersAdminRequestStatues? ordersAdminDeleteRequestStatues,
    String? errorMessage,
    OrdersAdminModel? ordersAdminModel,
    OrdersAdminRequestStatues? ordersAdminRequestStatues,
  }) {
    return OrdersAdminState(
      ordersAdminGetMoreRequestStatues: ordersAdminDeleteRequestStatues ??
          this.ordersAdminGetMoreRequestStatues,
      isEndOfData: isEndOfData ?? this.isEndOfData,
      ordersAdminDeleteRequestStatues: ordersAdminDeleteRequestStatues ??
          this.ordersAdminDeleteRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
      ordersAdminModel: ordersAdminModel ?? this.ordersAdminModel,
      ordersAdminRequestStatues:
          ordersAdminRequestStatues ?? this.ordersAdminRequestStatues,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        ordersAdminModel,
        ordersAdminGetMoreRequestStatues,
        isEndOfData,
        ordersAdminRequestStatues,
        ordersAdminDeleteRequestStatues,
        identityHashCode(this)
      ];
}
