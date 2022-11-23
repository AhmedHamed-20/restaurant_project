import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/services/service_locator.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/orders_admin_bloc.dart';
import '../widgets/orders_admin_main_widget.dart';

class AllOrdersAdminScreen extends StatelessWidget {
  const AllOrdersAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<OrdersAdminBloc>()
        ..add(OrdersAdminGetEvent(adminToken: accessTokenAdminVar)),
      child: BlocBuilder<OrdersAdminBloc, OrdersAdminState>(
        builder: (context, state) {
          switch (state.ordersAdminRequestStatues) {
            case OrdersAdminRequestStatues.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case OrdersAdminRequestStatues.success:
              return const OrdersAdminMainWidget();
            case OrdersAdminRequestStatues.error:
              return Center(
                child: Text(state.errorMessage),
              );
          }
        },
      ),
    );
  }
}
