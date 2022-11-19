import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';

import '../../models/orders_model.dart';
import '../../repositories/base/base_orders_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc(this.baseOrderRepository) : super(const OrdersState()) {
    on<MyOrdersEvent>(_getMyOrders);
    on<OrderRecipeEvent>(_orderRecipe);
    on<OrderResetBoolEvent>(_resetOrderBool);
  }
  final BaseOrderRepository baseOrderRepository;
  FutureOr<void> _getMyOrders(
      MyOrdersEvent event, Emitter<OrdersState> emit) async {
    final result = await baseOrderRepository
        .getMyOrders(MyOrderParams(token: event.token));
    result.fold((l) {
      emit(state.copyWith(
          errorMessage: l.message,
          ordersRequestStatues: OrdersRequestStatues.error));
    }, (r) {
      emit(state.copyWith(
          myOrders: r,
          ordersRequestStatues: OrdersRequestStatues.success,
          errorMessage: ''));
    });
  }

  FutureOr<void> _orderRecipe(
      OrderRecipeEvent event, Emitter<OrdersState> emit) async {
    final result = await baseOrderRepository.orderRecipe(OrderRecipeParams(
        token: event.token,
        orderContent: event.orderContent,
        address: event.address,
        phoneNumber: event.phoneNumber));
    result.fold((l) {
      emit(
        state.copyWith(
          errorMessage: l.message,
          ordersRequestStatues: OrdersRequestStatues.error,
          isOrderedSuccessfully: false,
        ),
      );
    }, (r) {
      emit(state.copyWith(
          isOrderedSuccessfully: true,
          ordersRequestStatues: OrdersRequestStatues.success,
          errorMessage: ''));
    });
  }

  FutureOr<void> _resetOrderBool(
      OrderResetBoolEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(isOrderedSuccessfully: false));
  }
}
