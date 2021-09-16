import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/admin_screens/categories_admin_screen.dart';
import 'package:resturant/screens/admin_screens/orders_admin_screen.dart';
import 'package:resturant/screens/admin_screens/recipes_admin_screen.dart';
import 'package:resturant/screens/admin_screens/users_admin_screen.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AppintiState());

  static AdminCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> screen = [
    UsersAdmin(),
    RecipesAdmin(),
    CategoriesAdmin(),
    OrdersAdmin(),
  ];
  List<String> title = [
    'Users',
    'Recipes',
    'Categories',
    'Orders',
  ];
  changBottomnav(int index) {
    currentindex = index;

    emit(ChangebottomState());
  }

  bool result = true;
  Future<bool> checkConnecthion() async {
    result = await InternetConnectionChecker().hasConnection;
    emit(HasConnecthion());
    return result;
  }

  List allUser;
  getAllusers(String token) {
    DioFunc.getdate(
      url: EndPoints.users,
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      allUser = value.data['data']['data'];
      print(allUser);
      emit(UsersGetSuccess());
    }).catchError((onError) {
      print(onError);
      emit(UsersGetError());
    });
  }

  deleteUserById(String token, String userId) {
    DioFunc.deleteData(
      url: '${EndPoints.users + userId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);
      getAllusers(token);
    }).catchError((onError) {
      print(onError);
    });
  }

  updateuser(String token, String userId, String name, String email,
      BuildContext context) {
    DioFunc.patchdata(
      url: '${EndPoints.users + userId}',
      token: token,
      name: name,
      email: email,
    ).then((value) {
      print(value);
      getAllusers(token);
      Navigator.of(context).pop();
    }).catchError((onError) {
      print(onError);
    });
  }
}
