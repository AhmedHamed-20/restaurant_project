import 'package:flutter/material.dart';

class PictureScreen extends StatelessWidget {
  String imageUrl;
  String recipeName;
  PictureScreen({@required this.imageUrl, @required this.recipeName});
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
          Expanded(
            child: Center(
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                child: Hero(
                  tag: 'tagadmin2',
                  child: Image.network(
                    imageUrl,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
