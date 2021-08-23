import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/states/login_states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/class_models/login_model.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/navigate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(AppintiState());
  static LoginCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> loginData;
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
        emit(LoginSuccess());

        CachFunc.putStringDate(key: 'token', data: EndPoints.loginModel.token)
            .then((value) {
          DataBaseFun.insertIntoDataBase(
              name: EndPoints.loginModel.data.user.name,
              email: EndPoints.loginModel.data.user.email,
              photourl: EndPoints.loginModel.data.user.photo);

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
