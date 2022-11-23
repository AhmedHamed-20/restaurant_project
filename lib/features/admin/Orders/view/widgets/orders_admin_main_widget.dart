import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/admin/Orders/view_model/bloc/orders_admin_bloc.dart';

import '../../../../../core/const/const.dart';
import 'delete_order_alert_dialog_widget.dart';
import 'orders_widget_model_bottom_sheet.dart';

class OrdersAdminMainWidget extends StatelessWidget {
  const OrdersAdminMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ordersBloc = BlocProvider.of<OrdersAdminBloc>(context);
    return BlocBuilder<OrdersAdminBloc, OrdersAdminState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.ordersAdminModel!.ordersData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                    isDismissible: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppRadius.r25),
                      ),
                    ),
                    backgroundColor: Theme.of(context).backgroundColor,
                    context: context,
                    builder: (context) {
                      return OrdersContentModelBottomSheetWidget(
                        orderContent: state
                            .ordersAdminModel!.ordersData[index].ordersContent,
                      );
                    });
              },
              child: ListTile(
                title: Text(
                  'Order From :${state.ordersAdminModel!.ordersData[index].customerName}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  'Total Price :${state.ordersAdminModel!.ordersData[index].totalPrice} EGP',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: ordersBloc,
                          child: DeleteOrderAlertDailogWidget(
                            orderId:
                                state.ordersAdminModel!.ordersData[index].id,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
