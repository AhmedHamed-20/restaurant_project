import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:resturant/layouts/admin_layout/admin_layout_screen.dart';
import 'package:resturant/layouts/user_layout/user_layout_screen.dart';
import 'package:resturant/models/bloc/states/login_states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/class_models/login_model.dart';
import 'package:resturant/models/databasae/cart_database.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/navigate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(AppintiState());
  static LoginCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> loginData;
  getbyuserid(String id, database) async {
    await CartDataBaseFun.getdataFromDataBaseByID(database, id).then((value) {
      EndPoints.FilteredCartDataBase = value;
      emit(DataGetSucces());
      print(EndPoints.FilteredCartDataBase);
    }).catchError((onError) {
      emit(DataGeterror());
      print(onError);
    });
  }

  bool result = true;
  Future<bool> checkConnecthion() async {
    result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  getdata(BuildContext context, {token}) async {
    print('YAY! Free cute dog pics!');
    if (CachFunc.getData('isAdmin') == null) {
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
            emit(DataGetSucces());
            print(EndPoints.allCategoriesMap);
          },
        ).catchError(
          (error) {
            emit(DataGeterror());
            print(error);
            //     print(EndPoints.token);
          },
        );
      });
    } else {
      print('its admin');
      await DioFunc.getdate(
        url: EndPoints.users,
        token: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      ).then((value) {
        EndPoints.allUser = value.data['data']['data'];
        emit(DataGetSucces());
        print(EndPoints.allUser);
        DioFunc.getdate(
          url: '${EndPoints.allOrders}',
          token: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ).then((value) {
          EndPoints.allorders = value.data['data']['data'];
          print(EndPoints.allorders);
          DioFunc.getdate(
            url: EndPoints.categories,
          ).then((value) {
            EndPoints.allCategories = value.data['data']['data'];
            emit(CategorieCreatedSuccess());
            print(EndPoints.allCategories);
            DioFunc.getdate(
              url: EndPoints.allRecipies,
            ).then((value) {
              EndPoints.allrecipesAdmin = value.data['data']['data'];
              print(EndPoints.allrecipesAdmin);
              emit(RecipesGetSuccess());
            }).catchError((onError) {
              print(onError);
              emit(RecipesGetError());
            });
          }).catchError((onError) {
            emit(CategorieCreatedError());
            print(onError);
          });
        }).catchError((onError) {
          print(onError);
        });
        emit(UsersGetSuccess());
      }).catchError((onError) {
        print(onError);
        emit(UsersGetError());
      });
    }
  }

  CachFunc cach;
  login(String email, String password, {BuildContext context, Widget screen}) {
    emit(LoginLoadingState());
    DioFunc.postData(
      EndPoints.Login,
      {
        'email': '${email}',
        'password': '${password}',
      },
    ).then(
      (value) async {
        EndPoints.loginModel = LoginModel.fromjson(value.data);
        //  print(loginmodel.status);

        loginData = Map<String, dynamic>.from(value.data);

        //  print(loginData);

        CachFunc.putStringDate(key: 'token', data: EndPoints.loginModel.token)
            .then((value) async {
          await DataBaseFun.insertIntoDataBase(
            name: EndPoints.loginModel.data.user.name,
            email: EndPoints.loginModel.data.user.email,
            photourl: EndPoints.loginModel.data.user.photo,
            userId: EndPoints.loginModel.data.user.id,
          );
          if (EndPoints.loginModel.data.user.role == 'admin') {
            CachFunc.putStringDate(key: 'isAdmin', data: 'admin').then((value) {
              print(value);
              getdata(context, token: EndPoints.loginModel.token);
              Fluttertoast.showToast(
                msg: 'Welcome ${loginData['data']['user']['name']}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigate(context: context, Screen: AdminLayout());
            });
          } else {
            DioFunc.getdate(url: EndPoints.allRecipies).then(
              (value) {
                EndPoints.allRecipiesMap =
                    Map<String, dynamic>.from(value.data);
                EndPoints.recipes = EndPoints.allRecipiesMap['data']['data'];
                print(EndPoints.allRecipiesMap);
                DioFunc.getdate(url: EndPoints.categories).then(
                  (value) {
                    EndPoints.allCategoriesMap =
                        Map<String, dynamic>.from(value.data);
                    getbyuserid(
                      DataBaseFun.storedData[0]['userId'],
                      CartDataBaseFun.database,
                    );
                    emit(HomeScreenGetSucces());
                    print(EndPoints.allCategoriesMap);
                    Fluttertoast.showToast(
                      msg: 'Welcome ${loginData['data']['user']['name']}',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigate(context: context, Screen: LayoutScreen());
                    //  print(EndPoints.token);
                  },
                ).catchError(
                  (error) {
                    emit(HomeScreenGetError());
                    print(error);
                    //     print(EndPoints.token);
                  },
                );

                //  print(EndPoints.token);
              },
            ).catchError(
              (error) {
                print(error);
                emit(HomeScreenGetError());
                //     print(EndPoints.token);
              },
            );
          }
        }).catchError((onError) {
          print(onError);
        });

        //  print(loginData['token']);

        // print(loginData['token']);
      },
    ).onError(
      (error, stackTrace) {
        print(email);
        print(error);
        Fluttertoast.showToast(
          msg: 'error ): make sure that your data is correct',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.SNACKBAR,
        );
        emit(LoginErrorState());
      },
    );
  }

  bool hidePassword = true;

  changehidepasswordState() {
    hidePassword = !hidePassword;
    emit(HidePasswordState());
  }
}
