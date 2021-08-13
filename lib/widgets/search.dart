import 'package:flutter/material.dart';

TextEditingController controller = TextEditingController();
Widget search() {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 15),
    child: TextField(
      style: TextStyle(
        color: Colors.black,
      ),
      textDirection: TextDirection.rtl,
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      onSubmitted: (val) {},
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
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
  );
}
