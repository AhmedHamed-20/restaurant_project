import 'package:flutter/material.dart';

import '../const/const.dart';

class RecipesCardWidget extends StatelessWidget {
  const RecipesCardWidget({
    super.key,
    required this.imageCover,
    required this.name,
    required this.price,
  });
  final String imageCover;
  final String name;
  final int price;
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
            CircleAvatar(
              radius: AppRadius.r40,
              backgroundImage: NetworkImage(
                imageCover,
              ),
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
          ],
        ),
      ),
    );
  }
}
