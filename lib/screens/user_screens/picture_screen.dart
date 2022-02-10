import 'dart:ffi';

import 'package:flutter/material.dart';

class PictureScreen extends StatelessWidget {
  String imageUrl;
  String recipeName;
  int index;
  PictureScreen(
      {@required this.imageUrl,
      @required this.recipeName,
      @required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          recipeName,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: InteractiveViewer(
                  panEnabled: false,
                  clipBehavior: Clip.none,
                  child: Hero(
                    tag: index.toString(),
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
