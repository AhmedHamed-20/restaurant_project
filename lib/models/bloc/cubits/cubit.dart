import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/cart_database.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/databasae/favorite_database.dart';
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
  Appcubit() : super(Appintistate());
  static Appcubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  bool ispressed = false;
  getbyuserid(String id, database) async {
    await CartDataBaseFun.getdataFromDataBaseByID(database, id).then((value) {
      EndPoints.FilteredCartDataBase = value;
      emit(DataGetSuccess());
      print(EndPoints.FilteredCartDataBase);
    }).catchError((onError) {
      emit(DataGetError());
      print(onError);
    });
  }

  insertIntoFavorite(String photourl, String recipeName, String price,
      String email, String slug, String userId, String recipeId) {
    FavoriteDataBaseFun.insertIntoDataBase(
            photourl: photourl,
            price: price,
            email: email,
            slug: slug,
            userId: userId,
            recipeName: recipeName,
            recipeId: recipeId)
        .then((value) {
      Fluttertoast.showToast(
          msg: 'Added to favorite',
          textColor: Colors.white,
          backgroundColor: Colors.green);
      changeLoveIconState = false;
      emit(favoriteInsertedSucces());
    }).catchError((onError) {
      print(onError);
      emit(favoriteInsertederror());
    });
  }

  Future createOrder(
      {List<Map> orderContent,
      String address,
      String phoneNum,
      String token,
      context,
      bool isAll,
      String recipeName,
      String userId}) {
    return DioFunc.postData(
      EndPoints.order,
      {
        'orderContent': orderContent,
        'customerAddress': '$address',
        'customerPhoneNumber': '$phoneNum'
      },
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then(
      (value) {
        print(value);

        isAll
            ? CartDataBaseFun.deleteFromDataBase(userId).then((value) {
                Fluttertoast.showToast(
                  msg: 'Ordered Success',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
                emit(orderSucces());
                Navigator.of(context).pop();
              })
            : CartDataBaseFun.deleteFromDataBaseNameandId(
                    recipeName, context, userId)
                .then((value) {
                Fluttertoast.showToast(
                  msg: 'Ordered Success',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
                emit(orderallSucces());
                Navigator.of(context).pop();
              });
      },
    ).catchError(
      (onError) {
        print(onError);
        emit(DataSenterror());
      },
    );
  }

  updateCardDataBase(
      {int amount, String id, String recipeName, BuildContext context}) {
    CartDataBaseFun.updateDataBase(amount, id, recipeName).then((value) {
      print(value);
      Fluttertoast.showToast(
          msg: 'Updated',
          backgroundColor: Colors.green,
          textColor: Colors.white);
      emit(updatedSucess());
      Navigator.of(context).pop();
    }).catchError((onError) {
      print(onError);
      emit(updatederror());
    });
  }

  chagestate() {
    emit(orderallerror());
  }

  chagestateIncrement() {
    emit(incrementstae());
  }

  chagestatedecrement() {
    emit(decrementstate());
  }

  getdata() {
    DioFunc.getdate(url: EndPoints.allRecipies).then((value) {
      EndPoints.allRecipiesMap = Map<String, dynamic>.from(value.data);
      print(EndPoints.allRecipiesMap);
      DioFunc.getdate(url: EndPoints.categories).then(
        (value) {
          EndPoints.allCategoriesMap = Map<String, dynamic>.from(value.data);
          getbyuserid(
            DataBaseFun.storedData[0]['userId'],
            CartDataBaseFun.database,
          );
          emit(DataGetSuccess());
          print(EndPoints.allCategoriesMap);
        },
      ).catchError(
        (error) {
          emit(DataGetError());
          print(error);
          //     print(EndPoints.token);
        },
      );
    });
  }

  Map<String, dynamic> OrdersMap;
  getmyOrders(String token) {
    emit(LoadingState());
    DioFunc.getdate(
      url: EndPoints.order,
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      OrdersMap = value.data;
      print(OrdersMap);
      emit(OrdersDatagetSuccess());
    }).onError((error, stackTrace) {
      print(error);
      emit(OrdersDatageterror());
    });
  }

  List<Widget> screen = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    OrderScreen(),
    FavoriteScreen(),
  ];
  bool changeLoveIconState = false;
  bool isInside = false;
  bool SearchIntoFavorite(String recipeName) {
    for (int i = 0; i <= FavoriteDataBaseFun.FavoriteDataBase.length; i++) {
      try {
        if (recipeName ==
            FavoriteDataBaseFun.FavoriteDataBase[i]['recipeName']) {
          return true;
        }
      } catch (onerror) {
        print(onerror);
      }
    }
    return false;
  }

  deleteFromFavorite(int id, context) {
    FavoriteDataBaseFun.deleteFromDataBase(id, context).then((value) {
      print('success');
      changeLoveIconState = false;
      Fluttertoast.showToast(
        msg: 'Deleted Success',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      emit(DataDealetedSuccess());
    }).catchError((onError) {
      emit(DataDealetedError());
      print(onError);
    });
  }

  deleteFromFavoriteByName(String name, context) {
    FavoriteDataBaseFun.deleteFromDataBaseName(name, context).then((value) {
      print('success');
      //    print(value);
      Fluttertoast.showToast(
        msg: 'Deleted from favorite',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      changeLoveIconState = false;
      emit(DataDealetedSuccess());
    }).catchError((onError) {
      emit(DataDealetedError());
      print(onError);
    });
  }

  changeLoveIcon() {
    changeLoveIconState = !changeLoveIconState;
    emit(ChangeIconState());
  }

  List<String> title = [
    'Home',
    'Categories',
    'Cart',
    'Orders',
    'Favorites',
  ];

//  searchinlist(String)
  changBottomnav(int index) {
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
      emit(DataGetSuccess());
    }).catchError((error) {
      print(error);
    });
  }

  dataBase() async {
    await DataBaseFun.createData();
    await CartDataBaseFun.createData();
    await FavoriteDataBaseFun.createData();
    emit(DataBaseCreated());
  }

  int numberOFricipes = 1;
  incrementNum() {
    numberOFricipes++;

    emit(NumState());
  }

  decrementNum() {
    if (numberOFricipes > 1) {
      numberOFricipes--;

      emit(NumState());
    }
  }

  Future<int> incrementNumincart() async {
    await numberOFricipes++;
    ispressed = true;

    emit(NumState());
    return numberOFricipes;
  }

  Future<int> decrementNumincart() async {
    if (numberOFricipes > 1) {
      await numberOFricipes--;
      ispressed = true;

      emit(NumState());
      return numberOFricipes;
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

  updateUser({String name, String email, @required String token, context}) {
    DioFunc.patchdata(
      url: EndPoints.updateMe,
      name: name,
      email: email,
      token: token,
    ).then((value) {
      DataBaseFun.updateDataBase(email, name).then((value) {
        Fluttertoast.showToast(
          msg: 'Updated successfully',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        emit(updatedSucess());
        Navigator.of(context).pop();
      });

      print(name + email);
      //  print(value);
    }).catchError(
      (onError) {
        print(onError);
      },
    );
  }

  deleteFromDataBase(int id, BuildContext context) {
    DataBaseFun.deleteFromDataBase(id, context).then((value) {
      emit(DeleteDataBase());
    });
  }
}
