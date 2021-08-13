import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';

Widget allFoods({
  BuildContext context,
  String name,
  String imageurl,
  String description,
  String price,
  AppState state,
  int index,
}) {
  var cubit = Appcubit.get(context);
  return Card(
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: Color(0xfff8f8f8),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Batka',
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '\$ ${price}',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Batka',
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CircleAvatar(
              backgroundImage: AssetImage(
                imageurl,
              ),
              radius: 55,
            ),
          ),
        ],
      ),
    ),
  );
}
