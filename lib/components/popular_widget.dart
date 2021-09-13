import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/detailes_screen.dart';
import 'package:resturant/widgets/navigate.dart';
import 'package:resturant/widgets/popular_foods.dart';

Widget popularWidget(BuildContext context) {
  var cubit = Appcubit.get(context);
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 7,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigate(
            context: context,
            Screen: DetailesScreen(
              index: index,
              name: EndPoints.allRecipiesMap['data']['data'][index + 2]['name'],
              imageurl: EndPoints.allRecipiesMap['data']['data'][index + 2]
                  ['imageCover'],
              price: EndPoints.allRecipiesMap['data']['data'][index + 2]
                  ['price'],
              descripthion: EndPoints.allRecipiesMap['data']['data'][index + 2]
                  ['category'],
              Ingridients: EndPoints.allRecipiesMap['data']['data'][index + 2]
                  ['ingredients'],
              email: DataBaseFun.storedData[0]['email'],
              userId: DataBaseFun.storedData[0]['userId'],
              recipeId: EndPoints.allRecipiesMap['data']['data'][index + 2]
                  ['_id'],
            ),
          );
        },
        child: popularFoods(
          name: EndPoints.allRecipiesMap['data']['data'][index + 2]['name'],
          context: context,
          price: EndPoints.allRecipiesMap['data']['data'][index + 2]['price']
              .toString(),
          imageUrl: EndPoints.allRecipiesMap['data']['data'][index + 2]
              ['imageCover'],
        ),
      );
    },
  );
}
