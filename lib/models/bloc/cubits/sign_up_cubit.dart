import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/states/sign_up_states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/class_models/sign_up_model.dart';
import 'package:resturant/models/databasae/database.dart';
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
        EndPoints.signUpModel = SignUpModel.fromjson(value.data);
        print(SignUpDate);
        CachFunc.putStringDate(
          key: 'token',
          data: EndPoints.signUpModel.token,
        ).then((value) {
          emit(SignUpSuccess());
          DataBaseFun.insertIntoDataBase(
            email: EndPoints.signUpModel.data.user.email,
            photourl: EndPoints.signUpModel.data.user.photo,
            name: EndPoints.signUpModel.data.user.name,
            userId: EndPoints.loginModel.data.user.id,
          ).then((value) {
            DioFunc.getdate(url: EndPoints.allRecipies).then((value) {
              EndPoints.allRecipiesMap = Map<String, dynamic>.from(value.data);
              print(EndPoints.allRecipiesMap);
              DioFunc.getdate(url: EndPoints.categories).then((value) {
                EndPoints.allCategoriesMap =
                    Map<String, dynamic>.from(value.data);
                Fluttertoast.showToast(
                  msg: DataBaseFun.storedData == null
                      ? 'error'
                      : 'Welcome ${DataBaseFun.storedData[0]['name']}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                Navigate(context: context, Screen: screen);
              });
            });
          });
        }).catchError((onError) {
          print(onError);
        });
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
