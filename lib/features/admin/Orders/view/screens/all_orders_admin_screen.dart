import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/services/service_locator.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/orders_admin_bloc.dart';

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
                            return SizedBox(
                              height: screenHeight(context) * 0.6,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: AppPadding.p10,
                                  right: AppPadding.p10,
                                  top: AppPadding.p10,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Order Information',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: ListTile(
                      title: Text(
                        state.ordersAdminModel!.ordersData[index].customerName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        state.ordersAdminModel!.ordersData[index]
                            .customerPhoneNumber,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  );
                },
              );
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
