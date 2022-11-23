import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/const/text_editing_controllers.dart';

import '../../../../../../core/utls/utls.dart';
import '../../view_model/bloc/admin_auth_bloc.dart';
import 'login_button_admin_design.dart';

class LoginAdminButtonsWidget extends StatelessWidget {
  const LoginAdminButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<AdminAuthBloc, AdminAuthState>(
          listener: (context, state) {
            if (state.adminAuthRequestStatues ==
                AdminAuthRequestStatues.success) {
              accessTokenAdminVar = state.adminModel!.token;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutesNames.adminLayout, (route) => false);
              TextEditingControllers.loginEmailAdminController.clear();
              TextEditingControllers.loginPasswordAdminController.clear();
            }
            if (state.adminAuthRequestStatues ==
                AdminAuthRequestStatues.error) {
              flutterToast(
                  msg: state.errorMessage,
                  backgroundColor: AppColors.toastError,
                  textColor: AppColors.white);
            }
          },
          builder: (context, state) {
            switch (state.adminAuthRequestStatues) {
              case AdminAuthRequestStatues.idle:
                return const LoginAdminButtonDesign();
              case AdminAuthRequestStatues.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case AdminAuthRequestStatues.success:
                return Text(
                  'Login Success',
                  style: Theme.of(context).textTheme.titleLarge,
                );

              case AdminAuthRequestStatues.error:
                return const LoginAdminButtonDesign();
            }
          },
        ),
      ],
    );
  }
}
