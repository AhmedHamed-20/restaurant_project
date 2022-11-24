import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/admin/Orders/view_model/bloc/orders_admin_bloc.dart';

import '../../../../../core/const/const.dart';
import 'delete_order_alert_dialog_widget.dart';
import 'orders_widget_model_bottom_sheet.dart';

int page = 2;

class OrdersAdminMainWidget extends StatefulWidget {
  const OrdersAdminMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersAdminMainWidget> createState() => _OrdersAdminMainWidgetState();
}

class _OrdersAdminMainWidgetState extends State<OrdersAdminMainWidget> {
  final ScrollController scrollController = ScrollController();
  bool isEnd = false;
  bool isLoadingg = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          isEnd == false) {
        //  page++;
        print(page);
        BlocProvider.of<OrdersAdminBloc>(context).add(OrdersAdminGetMoreEvent(
            adminToken: accessTokenAdminVar, page: page.toString()));
        page++;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    page = 2;
    isEnd = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ordersBloc = BlocProvider.of<OrdersAdminBloc>(context);
    return BlocConsumer<OrdersAdminBloc, OrdersAdminState>(
      listener: ((context, state) {
        isEnd = state.isEndOfData;
      }),
      builder: (context, state) {
        print('length is ${state.ordersAdminModel!.ordersData.length}');
        return ListView.builder(
          controller: scrollController,
          itemCount: state.ordersAdminModel!.ordersData.length + 1,
          itemBuilder: (context, index) {
            if (index < state.ordersAdminModel!.ordersData.length) {
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
                          orderContent: state.ordersAdminModel!
                              .ordersData[index].ordersContent,
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
            } else {
              return state.isEndOfData
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.all(AppPadding.p10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }
          },
        );
      },
    );
  }
}
