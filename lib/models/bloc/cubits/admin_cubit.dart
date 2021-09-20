import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  getAllusers(String token) {
    DioFunc.getdate(
      url: EndPoints.users,
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      EndPoints.allUser = value.data['data']['data'];
      print(EndPoints.allUser);
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

  getAllOrders(String token) {
    DioFunc.getdate(
      url: '${EndPoints.allOrders}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      EndPoints.allorders = value.data['data']['data'];
      print(EndPoints.allorders);
    }).catchError((onError) {
      print(onError);
    });
  }

  getAllCategories() {
    DioFunc.getdate(
      url: EndPoints.categories,
    ).then((value) {
      EndPoints.allCategories = value.data['data']['data'];
      emit(CategorieCreatedSuccess());
      print(EndPoints.allCategories);
    }).catchError((onError) {
      emit(CategorieCreatedError());
      print(onError);
    });
  }

  createNewRecipe(String token, String categorieName, BuildContext context) {
    DioFunc.postData(
      EndPoints.categories,
      {'name': categorieName},
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) async {
      print(value);

      Navigator.of(context).pop();
      await getAllCategories();
      emit(CategorieCreatedSuccess());
    }).catchError((onError) {
      emit(CategorieCreatedError());
      print(onError);
    });
  }

  deleteCategorie(String token, String CategorieId) {
    DioFunc.deleteData(
      url: '${EndPoints.categories + CategorieId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      print(value);
      getAllCategories();
    }).catchError((onError) {
      print(onError);
    });
  }

  editCategorieName(
      String name, String token, String CategorieID, BuildContext context) {
    DioFunc.patchCategoriedata(
      url: '${EndPoints.categories + CategorieID}',
      token: token,
      name: name,
    ).then((value) {
      print(value);
      Navigator.of(context).pop();
      getAllCategories();
    }).catchError((onError) {
      print(onError);
    });
  }

  int page = 2;
  bool noData = false;
  pageinathionOrders(String token) {
    emit(PageLoading());
    DioFunc.getdate(
      url: '${EndPoints.allOrdersPage + page.toString()}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((
      value,
    ) {
      // print(value.data['results']);
      if (value.data['results'] == 0) {
        page = page;
        noData = true;
        Fluttertoast.showToast(
          msg: 'End of data ):',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        emit(PageGetEnd());
      } else {
        page++;
        print(EndPoints.allorders.length);
        EndPoints.allorders.addAll(value.data['data']['data']);
        print(EndPoints.allorders);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }
}
