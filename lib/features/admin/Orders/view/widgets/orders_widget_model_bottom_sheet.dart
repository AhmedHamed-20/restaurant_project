import 'package:flutter/material.dart';

import '../../../../../core/const/const.dart';
import '../../models/order_content_model.dart';

class OrdersContentModelBottomSheetWidget extends StatelessWidget {
  const OrdersContentModelBottomSheetWidget({
    required this.orderContent,
    Key? key,
  }) : super(key: key);
  final List<OrderAdminContentModel> orderContent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * 0.4,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p10,
          right: AppPadding.p10,
          top: AppPadding.p10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Text(
              'Order Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: orderContent.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Name :${orderContent[index].recipeName}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount :${orderContent[index].recipeAmount}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Price :${orderContent[index].recipePrice} EGP',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
