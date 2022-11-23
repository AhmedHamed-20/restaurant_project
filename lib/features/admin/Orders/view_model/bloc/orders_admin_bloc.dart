import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/admin/Orders/models/orders_model.dart';
import 'package:resturant/features/admin/Orders/repository/base/base_admin_orders_repository.dart';

part 'orders_admin_event.dart';
part 'orders_admin_state.dart';

class OrdersAdminBloc extends Bloc<OrdersAdminEvent, OrdersAdminState> {
  OrdersAdminBloc(this.baseAdminOrdersRepository)
      : super(const OrdersAdminState()) {
    on<OrdersAdminGetEvent>(_getAllOrdersAdmin);
    on<OrdersAdminCancleEvent>(_cancelOrderAdmin);
  }
  final BaseAdminOrdersRepository baseAdminOrdersRepository;
  FutureOr<void> _getAllOrdersAdmin(
      OrdersAdminGetEvent event, Emitter<OrdersAdminState> emit) async {
    final result = await baseAdminOrdersRepository
        .getAllOrders(AdminOrdersGetParams(adminToken: event.adminToken));

    result.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        ordersAdminRequestStatues: OrdersAdminRequestStatues.error,
      ));
    }, (r) {
      emit(state.copyWith(
        ordersAdminModel: r,
        errorMessage: '',
        ordersAdminRequestStatues: OrdersAdminRequestStatues.success,
      ));
    });
  }

  FutureOr<void> _cancelOrderAdmin(
      OrdersAdminCancleEvent event, Emitter<OrdersAdminState> emit) async {
    final result = await baseAdminOrdersRepository.cancelOrder(
        AdminOrdersCancleParams(
            adminToken: event.adminToken, orderId: event.orderId));
    result.fold((l) {
      emit(state.copyWith(
        errorMessage: l.message,
        ordersAdminDeleteRequestStatues: OrdersAdminRequestStatues.error,
      ));
    }, (r) {
      emit(state.copyWith(
        errorMessage: '',
        ordersAdminDeleteRequestStatues: OrdersAdminRequestStatues.success,
      ));
      add(OrdersAdminGetEvent(adminToken: event.adminToken));
    });
  }
}
