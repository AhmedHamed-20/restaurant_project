import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';

TextEditingController controller = TextEditingController();
Widget search(context) {
  var cubit = Appcubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 15),
    child: TextField(
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      onSubmitted: (val) {
        cubit.search(controller.text);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.orangeAccent,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        labelText: 'Search',
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.black,
            )),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
