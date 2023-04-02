import 'package:flutter/material.dart';

import '../const/const.dart';
import 'cached_network_image_circle_photo.dart';

class RecipesCardWidget extends StatelessWidget {
  const RecipesCardWidget({
    super.key,
    required this.imageCover,
    required this.name,
    required this.price,
    this.trailingWidget = const SizedBox.shrink(),
  });
  final String imageCover;
  final String name;
  final int price;
  final Widget trailingWidget;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Row(
          children: [
            CachedNetworkImageCirclePhoto(
              photoRadius: 80,
              photoUrl: imageCover,
            ),
            const SizedBox(
              width: AppWidth.w10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '$price EGP',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Spacer(),
            trailingWidget,
          ],
        ),
      ),
    );
  }
}
