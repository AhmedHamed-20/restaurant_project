import 'package:flutter/material.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/dio/end_points.dart';

TextEditingController controller = TextEditingController();
Widget search(context) {
  var cubit = Appcubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 15),
    child: TextField(
      style: TextStyle(
        color: EndPoints.isDark
            ? Colors.white
            : EndPoints.isDark
                ? Colors.white
                : Colors.black,
      ),
      cursorColor: EndPoints.isDark
          ? Colors.white
          : EndPoints.isDark
              ? Colors.white
              : Colors.black,
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
            color: EndPoints.isDark
                ? Colors.white
                : EndPoints.isDark
                    ? Colors.white
                    : Colors.black,
          ),
        ),
        labelText: 'Search',
        labelStyle: TextStyle(
            color: EndPoints.isDark
                ? Colors.white
                : EndPoints.isDark
                    ? Colors.white
                    : Colors.black),
        prefixIcon: Icon(
          Icons.search,
          color: EndPoints.isDark
              ? Colors.white
              : EndPoints.isDark
                  ? Colors.white
                  : Colors.black,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: EndPoints.isDark
                  ? Colors.white
                  : EndPoints.isDark
                      ? Colors.white
                      : Colors.black,
            )),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: EndPoints.isDark
                ? Colors.white
                : EndPoints.isDark
                    ? Colors.white
                    : Colors.black,
          ),
        ),
      ),
    ),
  );
}
