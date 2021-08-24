import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
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
      itemCount: cubit.allRecipies['results'],
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigate(
              context: context,
              Screen: DetailesScreen(
                index: index,
                name: cubit.allRecipies['data']['data'][index]['name'],
                imageurl: cubit.allRecipies['data']['data'][index]
                    ['imageCover'],
                price: cubit.allRecipies['data']['data'][index]['price']
                    .toString(),
                descripthion: cubit.allRecipies['data']['data'][index]['slug'],
                Ingridients: cubit.allRecipies['data']['data'][index]
                    ['ingredients'],
              ),
            );
          },
          child: popularFoods(
            name: cubit.allRecipies['data']['data'][index]['name'],
            context: context,
            price: cubit.allRecipies['data']['data'][index]['price'].toString(),
            imageUrl: cubit.allRecipies['data']['data'][index]['imageCover'],
          ),
        );
      },
    ),
  );
}
