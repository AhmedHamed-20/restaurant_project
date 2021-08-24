import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';

Widget popularFoods(
    {BuildContext context, String name, String price, String imageUrl}) {
  var cubit = Appcubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(
      left: 15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
          radius: 55,
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontFamily: 'Batka',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '\$ ${price}',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontFamily: 'Batka',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
