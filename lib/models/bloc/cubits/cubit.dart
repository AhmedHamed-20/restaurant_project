import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'You can cancel your order within 5 minutes',
                        style: TextStyle(color: Colors.black),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      content: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 3,
                    );
                  },
                );
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
              }).then((value) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'You can cancel your order within 5 minutes',
                        style: TextStyle(color: Colors.black),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      content: MaterialButton(
                        onPressed: () {
                          Navigator.of(_).pop();
                        },
                        child: Text('Ok'),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 3,
                    );
                  },
                );
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

  bool result = true;
  Future<bool> checkConnecthion() async {
    result = await InternetConnectionChecker().hasConnection;
    emit(HasConnecthion());
    return result;
  }

  getdata(BuildContext context) async {
    print('YAY! Free cute dog pics!');
    DioFunc.getdate(url: EndPoints.allRecipies).then((value) {
      EndPoints.allRecipiesMap = Map<String, dynamic>.from(value.data);
      EndPoints.recipes = EndPoints.allRecipiesMap['data']['data'];
      print(EndPoints.recipes);
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

  int page = 2;
  bool noData = false;
  pageinathion() {
    emit(PageLoading());
    DioFunc.getdate(url: '${EndPoints.allRecipiesPage + page.toString()}')
        .then((value) {
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
        EndPoints.recipes.addAll(value.data['data']['data']);
        print(EndPoints.recipes);
        emit(PageGetSuccess());
      }
    }).onError((error, stackTrace) {
      print(error);
      emit(PageGetError());
    });
  }

  cancelOrder(String recipeId, String token) {
    DioFunc.deleteData(
      url: '${EndPoints.order + recipeId}',
      token: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((value) {
      emit(CanceledSuccess());
      getmyOrders(token);
      print(value);
    }).catchError((onError) {
      Fluttertoast.showToast(
        msg:
            'Oh man you can\'t cancel order after 5 minutes because we will not eat it ',
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
      );
      emit(CanceledError());
      print(onError);
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
