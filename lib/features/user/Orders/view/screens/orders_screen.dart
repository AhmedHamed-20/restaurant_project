import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/services/service_locator.dart';
import 'package:resturant/features/user/Orders/view_model/bloc/orders_bloc.dart';

import '../../../../../core/utls/utls.dart';
import '../widgets/main_orders_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => serviceLocator<OrdersBloc>()
          ..add(
            MyOrdersEvent(token: accessTokenVar),
          ),
        child: BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
          switch (state.ordersRequestStatues) {
            case OrdersRequestStatues.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case OrdersRequestStatues.success:
              return const MainOrdersWidget();
            case OrdersRequestStatues.error:
              return Center(
                child: Text(state.errorMessage),
              );
          }
        }));
  }
}
