import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/states/login_states.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/navigate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(AppintiState());
  static LoginCubit get(context) => BlocProvider.of(context);
  Map<String, dynamic> loginData;
  login(String email, String password, {BuildContext context, Widget screen}) {
    emit(LoginLoadingState());
    DioFunc.postData(
      EndPoints.Login,
      {
        'email': '${email}',
        'password': '${password}',
      },
    ).then(
      (value) {
        loginData = Map<String, dynamic>.from(value.data);
        print(loginData);
        emit(LoginSuccess());
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
