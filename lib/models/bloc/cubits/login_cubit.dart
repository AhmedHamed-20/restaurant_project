import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            .then((value) {
          DataBaseFun.insertIntoDataBase(
            name: EndPoints.loginModel.data.user.name,
            email: EndPoints.loginModel.data.user.email,
            photourl: EndPoints.loginModel.data.user.photo,
            userId: EndPoints.loginModel.data.user.id,
          );
          DioFunc.getdate(url: EndPoints.allRecipies).then(
            (value) {
              EndPoints.allRecipiesMap = Map<String, dynamic>.from(value.data);
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
                  Navigate(context: context, Screen: screen);
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
