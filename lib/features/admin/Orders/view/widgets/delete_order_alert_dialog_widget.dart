import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/Orders/view_model/bloc/orders_admin_bloc.dart';

import '../../../../../core/utls/utls.dart';

class DeleteOrderAlertDailogWidget extends StatelessWidget {
  const DeleteOrderAlertDailogWidget({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;
  @override
  Widget build(BuildContext context) {
    var ordersBloc = BlocProvider.of<OrdersAdminBloc>(context);
    return BlocConsumer<OrdersAdminBloc, OrdersAdminState>(
      listener: (context, state) {
        if (state.ordersAdminDeleteRequestStatues ==
            OrdersAdminRequestStatues.success) {
          flutterToast(
              msg: 'Deleted Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.pop(context);
        }
        if (state.ordersAdminDeleteRequestStatues ==
            OrdersAdminRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to delete this order?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            TextButton(
              onPressed: () {
                ordersBloc.add(
                  OrdersAdminCancleEvent(
                    adminToken: accessTokenAdminVar,
                    orderId: orderId,
                  ),
                );
              },
              child: Text(
                'Yes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
