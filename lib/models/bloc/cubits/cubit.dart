import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/cart_favorite_database.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/cart_screen.dart';
import 'package:resturant/screens/categories_screen.dart';
import 'package:resturant/screens/favorite_screen.dart';
import 'package:resturant/screens/home_screen.dart';
import 'package:resturant/screens/login_screen.dart';
import 'package:resturant/screens/order_screen.dart';
import 'package:resturant/widgets/navigate.dart';

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

  Map<String, dynamic> searchMap;
  search(String text) {
    DioFunc.getdate(
      url: EndPoints.search,
      query: {'s': '${text}'},
    ).then((value) {
      searchMap = Map<String, dynamic>.from(value.data);
      print(searchMap);
      print(searchMap.length);
      emit(DataGetSucces());
    }).catchError((error) {
      print(error);
    });
  }

  dataBase() async {
    await DataBaseFun.createData();
    await CartDataBaseFun.createData();
    emit(DataBaseCreated());
  }

  int numberOFricipes = 0;
  incrementNum() {
    numberOFricipes++;
    emit(NumState());
  }

  decrementNum() {
    if (numberOFricipes > 0) {
      numberOFricipes--;
      emit(NumState());
    }
  }

  bool IslogedOut = false;
  Future<bool> logout(String key, BuildContext context) async {
    await CachFunc.deleteData(key).then((value) {
      IslogedOut = value;
      NavigateandReplace(context: context, Screen: LoginScreen());
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
