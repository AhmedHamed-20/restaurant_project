import 'package:flutter/material.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/screens/detailes_screen.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/navigate.dart';

class CategoriesDetailes extends StatelessWidget {
  Map<String, dynamic> Data;
  CategoriesDetailes({this.Data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Categories Detailes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Data['results'] == 0
          ? Center(
              child: Text(
                'No recipes to show in this category',
                style: TextStyle(fontSize: 18, fontFamily: 'Batka'),
              ),
            )
          : ListView.builder(
              itemCount: Data['data']['data'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigate(
                      context: context,
                      Screen: DetailesScreen(
                        name: Data['data']['data'][index]['name'],
                        imageurl: Data['data']['data'][index]['imageCover'],
                        price: Data['data']['data'][index]['price'],
                        descripthion: Data['data']['data'][index]['category'],
                        Ingridients: Data['data']['data'][index]['ingredients'],
                        recipeId: Data['data']['data'][index]['_id'],
                        userId: DataBaseFun.storedData[0]['userId'],
                      ),
                    );
                  },
                  child: allFoods(
                    context: context,
                    name: Data['data']['data'][index]['name'],
                    imageurl: Data['data']['data'][index]['imageCover'],
                    price: Data['data']['data'][index]['price'].toString(),
                    description: Data['data']['data'][index]['category'],
                    Ingredients: Data['data']['data'][index]['ingredients'],
                  ),
                );
              }),
    );
  }
}
