import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:flutter/material.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/cart_screen.dart';
import 'package:resturant/screens/categories_screen.dart';
import 'package:resturant/screens/favorite_screen.dart';
import 'package:resturant/screens/home_screen.dart';
import 'package:resturant/screens/order_screen.dart';

class Appcubit extends Cubit<AppState> {
  Appcubit() : super(AppintiState());
  static Appcubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<Widget> screen = [
    HomeScreen(),
    CategoriesScreen(),
    CardScreen(),
    OrderScreen(),
    FavoriteScreen(),
  ];

  List<String> title = [
    'Home',
    'Categories',
    'Cart',
    'Orders',
    'Favorites',
  ];

  void changBottomnav(int index) {
    currentindex = index;

    emit(ChangebottomState());
  }

  getRecipies() async {
    await DioFunc.getdate(url: EndPoints.allRecipies).then(
      (value) {
        print(value);
        //  print(EndPoints.token);
      },
    ).catchError(
      (error) {
        print(error);
        //     print(EndPoints.token);
      },
    );
  }

  dataBase() {
    DataBaseFun.createData();
    emit(DataBaseCreated());
  }

  bool IslogedOut = false;
  Future<bool> logout(String key) async {
    await CachFunc.deleteData(key).then((value) {
      IslogedOut = value;
      emit(LogoutState());
      return value;
    }).catchError((onError) {
      print(onError);
    });
  }

  deleteFromDataBase(int id, BuildContext context) {
    DataBaseFun.deleteFromDataBase(id, context).then((value) {
      emit(DeleteDataBase());
    });
  }
}
