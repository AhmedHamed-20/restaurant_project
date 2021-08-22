import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/states/sign_up_states.dart';
import 'package:resturant/models/dio/dio.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/navigate.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(AppintiState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> SignUpDate;
  SignUp(String userName, String email, String password, String passwordConfirm,
      {BuildContext context, Widget screen}) {
    emit(SignUpLoadingState());
    DioFunc.postData(
      EndPoints.SignUp,
      {
        'name': '${userName}',
        'email': '${email}',
        'password': '${password}',
        'passwordConfirm': '${passwordConfirm}',
      },
    ).then(
      (value) {
        SignUpDate = Map<String, dynamic>.from(value.data);
        print(SignUpDate);
        emit(SignUpSuccess());
        Fluttertoast.showToast(
          msg: 'Welcome ${SignUpDate['data']['user']['name']}',
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
        emit(SignUpErrorState());
      },
    );
  }

  bool hidePassword1 = true;
  bool hidePassword2 = true;
  changehidepasswordState() {
    hidePassword1 = !hidePassword1;
    emit(HidePasswordState());
  }

  changehidepasswordState2() {
    hidePassword2 = !hidePassword2;
    emit(HidePasswordState());
  }
}
