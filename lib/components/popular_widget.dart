import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/detailes_screen.dart';
import 'package:resturant/widgets/navigate.dart';
import 'package:resturant/widgets/popular_foods.dart';

Widget popularWidget(BuildContext context) {
  var cubit = Appcubit.get(context);
  return Expanded(
    flex: 3,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: EndPoints.allRecipiesMap['results'],
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigate(
              context: context,
              Screen: DetailesScreen(
                index: index,
                name: EndPoints.allRecipiesMap['data']['data'][index]['name'],
                imageurl: EndPoints.allRecipiesMap['data']['data'][index]
                    ['imageCover'],
                price: EndPoints.allRecipiesMap['data']['data'][index]['price']
                    .toString(),
                descripthion: EndPoints.allRecipiesMap['data']['data'][index]
                    ['slug'],
                Ingridients: EndPoints.allRecipiesMap['data']['data'][index]
                    ['ingredients'],
              ),
            );
          },
          child: popularFoods(
            name: EndPoints.allRecipiesMap['data']['data'][index]['name'],
            context: context,
            price: EndPoints.allRecipiesMap['data']['data'][index]['price']
                .toString(),
            imageUrl: EndPoints.allRecipiesMap['data']['data'][index]
                ['imageCover'],
          ),
        );
      },
    ),
  );
}
