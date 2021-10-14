import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/databasae/favorite_database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/all_fodods.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Appcubit.get(context);
        return FavoriteDataBaseFun.FavoriteDataBase.isEmpty
            ? Center(
                child: Text(
                  'Add your favorite recipes now',
                  style: TextStyle(
                    color: EndPoints.isDark
                        ? Colors.white
                        : EndPoints.isDark
                            ? Colors.white
                            : Colors.black,
                    fontSize: 18,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: FavoriteDataBaseFun.FavoriteDataBase.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.orangeAccent,
                    ),
                    onDismissed: (directhion) {
                      cubit.deleteFromFavorite(
                          FavoriteDataBaseFun.FavoriteDataBase[index]['id'],
                          context);
                    },
                    child: allFoods(
                      price: FavoriteDataBaseFun.FavoriteDataBase[index]
                              ['price']
                          .toString(),
                      description: FavoriteDataBaseFun.FavoriteDataBase[index]
                          ['slug'],
                      imageurl: FavoriteDataBaseFun.FavoriteDataBase[index]
                          ['photourl'],
                      name: FavoriteDataBaseFun.FavoriteDataBase[index]
                          ['recipeName'],
                      index: index,
                      context: context,
                    ),
                  );
                },
              );
      },
    );
  }
}
