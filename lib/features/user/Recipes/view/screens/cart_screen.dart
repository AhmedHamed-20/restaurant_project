import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/widget/orders_bottom_sheet_content.dart';

import '../../../Orders/view_model/bloc/orders_bloc.dart';
import '../../view_model/bloc/recipes_bloc.dart';
import '../widgets/main_cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var recipeBloc = BlocProvider.of<RecipesBloc>(context);
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state.isOrderedSuccessfully) {
          recipeBloc.add(const CartRemoveAllEvent());
        }
      },
      child: Scaffold(
        floatingActionButton: BlocBuilder<RecipesBloc, RecipesState>(
          builder: (context, state) {
            if (state.cartModel.isEmpty) {
              return const SizedBox.shrink();
            }
            return MaterialButton(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r25),
              ),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Theme.of(context).backgroundColor,
                    enableDrag: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppRadius.r25),
                        topRight: Radius.circular(AppRadius.r25),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return OrderBottomSheetContent(
                          orderContent: state.cartModel
                              .map((e) => {
                                    'recipeId': e.recipeId,
                                    'amount': e.amount,
                                  })
                              .toList());
                    });
              },
              child: Text(
                'Order Now',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.white),
              ),
            );
          },
        ),
        body: const MainCartWidget(),
      ),
    );
  }
}
