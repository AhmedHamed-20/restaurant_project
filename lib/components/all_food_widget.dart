import 'package:flutter/material.dart';
import 'package:resturant/widgets/all_fodods.dart';

Widget allFoodWidget(state) {
  return Expanded(
    flex: 4,
    child: ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return allFoods(
          name: 'Pizza',
          context: context,
          state: state,
          index: index,
          imageurl: 'assets/images/pizza.jpg',
          price: '5',
          description:
              'Pizza (Italian: [ˈpittsa], Neapolitan: [ˈpittsə]) is an Italian dish consisting of a usually round',
        );
      },
    ),
  );
}
