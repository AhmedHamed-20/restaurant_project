import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';

Widget popularFoods(
    {BuildContext context, String name, String price, String imageUrl}) {
  var cubit = Appcubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(
      left: 10,
      right: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontFamily: 'Batka',
                ),
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
      ],
    ),
  );
}
