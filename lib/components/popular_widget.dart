import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/user_screens/detailes_screen.dart';
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
              name: EndPoints.recipes[index]['name'],
              imageurl: EndPoints.recipes[index]['imageCover'],
              price: EndPoints.recipes[index]['price'],
              descripthion: EndPoints.recipes[index]['category'],
              Ingridients: EndPoints.recipes[index]['ingredients'],
              email: DataBaseFun.storedData[0]['email'],
              userId: DataBaseFun.storedData[0]['userId'],
              recipeId: EndPoints.recipes[index]['_id'],
            ),
          );
        },
        child: popularFoods(
          name: EndPoints.recipes[index]['name'],
          context: context,
          price: EndPoints.recipes[index]['price'].toString(),
          imageUrl: EndPoints.recipes[index]['imageCover'],
        ),
      );
    },
  );
}
