import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/user/Orders/view_model/bloc/orders_bloc.dart';

import '../../../../../core/const/const.dart';

class MainOrdersWidget extends StatelessWidget {
  const MainOrdersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) => ListView.builder(
          itemCount: state.myOrders.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.myOrders[index].ordersContent.length,
                      itemBuilder: (context, orderContentIndex) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.myOrders[index]
                                .ordersContent[orderContentIndex].recipeName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'amount:${state.myOrders[index].ordersContent[orderContentIndex].recipeAmount.toString()}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: MaterialButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r25)),
                              onPressed: () {},
                              child: Text(
                                'cancel',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: AppColors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(thickness: 2),
                    Row(
                      children: [
                        Text(
                          'Total Price:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          ' ${state.myOrders[index].totalPrice.toString()} EGP',
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
