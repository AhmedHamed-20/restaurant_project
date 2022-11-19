import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/widget/defaults.dart';
import 'package:resturant/features/user/Orders/view_model/bloc/orders_bloc.dart';

import '../const/text_editing_controllers.dart';

class OrderBottomSheetContent extends StatelessWidget {
  const OrderBottomSheetContent({super.key, required this.orderContent});
  final List<Map<String, dynamic>> orderContent;
  @override
  Widget build(BuildContext context) {
    var ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state.isOrderedSuccessfully) {
          flutterToast(
              msg: 'Ordered success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          ordersBloc.add(const OrderResetBoolEvent());
          TextEditingControllers.addressOrderController.clear();
          TextEditingControllers.phoneNymberOrderController.clear();
          Navigator.pop(context);
        }
      },
      child: SizedBox(
        height: screenHeight(context) * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              Text(
                'Order Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultTextField(
                context: context,
                controller: TextEditingControllers.addressOrderController,
                title: 'Address',
                prefixIcon: Icon(Icons.location_on,
                    color: Theme.of(context).iconTheme.color),
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultTextField(
                context: context,
                controller: TextEditingControllers.phoneNymberOrderController,
                title: 'Phome Number',
                prefixIcon:
                    Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              MaterialButton(
                height: AppHeight.h46,
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.r25,
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppRadius.r25,
                            ),
                          ),
                          title: Text(
                            'Order',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          content: Text(
                            'Please confirm your order',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                ordersBloc.add(
                                  OrderRecipeEvent(
                                    token: accessTokenVar,
                                    orderContent: orderContent,
                                    address: TextEditingControllers
                                        .addressOrderController.text
                                        .trim(),
                                    phoneNumber: TextEditingControllers
                                        .phoneNymberOrderController.text
                                        .trim(),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Confirm',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Text(
                  'Order Now',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
