import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/dio/end_points.dart';

Widget customeDialog(
    TextEditingController addressController,
    TextEditingController PhoneNumberController,
    BuildContext context,
    String recipeId,
    String token,
    int amount,
    String recipeName,
    String userId,
    {bool isCart}) {
  var cubit = Appcubit.get(context);
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    elevation: 2,
    child: Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'We need this data (:',
            style: TextStyle(
              color: EndPoints.isDark ? Colors.white : Colors.black,
              fontSize: 18,
              fontFamily: 'Bakta',
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: TextStyle(
                color: EndPoints.isDark ? Colors.white : Colors.black,
              ),
              cursorColor: EndPoints.isDark ? Colors.white : Colors.black,
              controller: addressController,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onSubmitted: (val) {},
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: EndPoints.isDark ? Colors.white : Colors.black,
                  ),
                ),
                labelText: 'Address',
                labelStyle: TextStyle(
                    color: EndPoints.isDark ? Colors.white : Colors.black),
                prefixIcon: Icon(
                  Icons.place,
                  color: EndPoints.isDark ? Colors.white : Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: EndPoints.isDark ? Colors.white : Colors.black,
                )),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: EndPoints.isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: TextStyle(
                color: EndPoints.isDark ? Colors.white : Colors.black,
              ),
              cursorColor: EndPoints.isDark ? Colors.white : Colors.black,
              controller: PhoneNumberController,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              onSubmitted: (val) {},
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: EndPoints.isDark ? Colors.white : Colors.black,
                  ),
                ),
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                    color: EndPoints.isDark ? Colors.white : Colors.black),
                prefixIcon: Icon(
                  Icons.phone,
                  color: EndPoints.isDark ? Colors.white : Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: EndPoints.isDark ? Colors.white : Colors.black,
                )),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: EndPoints.isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 250,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                cubit.createOrder(
                  orderContent: [
                    {'recipeId': '$recipeId', 'amount': amount}
                  ],
                  address: addressController.text,
                  phoneNum: PhoneNumberController.text,
                  token: token,
                  context: context,
                  isAll: false,
                  recipeName: recipeName,
                  userId: userId,
                );
              },
              child: Text(
                'Order Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Bakta',
                  fontWeight: FontWeight.w900,
                ),
              ),
              color: Colors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
