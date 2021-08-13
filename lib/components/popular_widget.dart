import 'package:flutter/material.dart';
import 'package:resturant/widgets/popular_foods.dart';

Widget popularWidget() {
  return Expanded(
    flex: 2,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) {
        return popularFoods(
          name: 'Pizza',
          context: context,
          price: '5',
          imageUrl: 'assets/images/pizza.jpg',
        );
      },
    ),
  );
}
