part of 'orders_admin_bloc.dart';

abstract class OrdersAdminEvent extends Equatable {
  const OrdersAdminEvent();
}

class OrdersAdminGetEvent extends OrdersAdminEvent {
  final String adminToken;
  const OrdersAdminGetEvent({required this.adminToken});
  @override
  List<Object?> get props => [adminToken];
}

class OrdersAdminCancleEvent extends OrdersAdminEvent {
  final String adminToken;
  final String orderId;
  const OrdersAdminCancleEvent(
      {required this.adminToken, required this.orderId});
  @override
  List<Object?> get props => [adminToken, orderId];
}
