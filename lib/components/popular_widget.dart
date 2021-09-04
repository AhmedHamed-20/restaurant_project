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
                  ['category'],
              Ingridients: EndPoints.allRecipiesMap['data']['data'][index]
                  ['ingredients'],
              email: DataBaseFun.storedData[0]['email'],
              userId: DataBaseFun.storedData[0]['userId'],
              recipeId: EndPoints.allRecipiesMap['data']['data'][index]['_id'],
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
  );
}
