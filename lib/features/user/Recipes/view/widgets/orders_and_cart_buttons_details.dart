import 'package:flutter/material.dart';

import '../../../../../core/const/const.dart';

class OrdersAndCartDetailsButtonsWidget extends StatelessWidget {
  const OrdersAndCartDetailsButtonsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          height: AppHeight.h46,
          color: AppColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.r25,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Order Now',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        MaterialButton(
          height: AppHeight.h46,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.r25,
            ),
          ),
          onPressed: () {},
          child: Text(
            'Add to Cart',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                ),
          ),
        )
      ],
    );
  }
}
