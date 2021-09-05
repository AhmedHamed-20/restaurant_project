import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';

Widget bottomSheetContent({
  TextEditingController addressController,
  TextEditingController PhoneNumberController,
  BuildContext context,
  List<Map> orders,
  String token,
  String userId,
  bool isAll,
  String recipeName,
}) {
  var cubit = Appcubit.get(context);
  return SingleChildScrollView(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'We need this data (:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Bakta',
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              controller: addressController,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onSubmitted: (val) {},
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                labelText: 'Address',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.place,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                )),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              controller: PhoneNumberController,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              onSubmitted: (val) {},
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                )),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
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
                  orderContent: orders,
                  address: addressController.text,
                  phoneNum: PhoneNumberController.text,
                  token: token,
                  context: context,
                  isAll: isAll,
                  userId: userId,
                  recipeName: recipeName,
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
