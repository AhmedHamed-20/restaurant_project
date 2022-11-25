import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';

import '../../../../../../core/utls/utls.dart';
import '../../../view_model/bloc/auth_bloc.dart';
import 'dont_have_account_widget.dart';
import 'login_button_design.dart';

class LoginButtonsWidget extends StatelessWidget {
  const LoginButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutesNames.forgetPasswordScreen);
            },
            child: Text(
              'Forget your password ?',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.orangeAccent),
            ),
          ),
        ),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.loginRequestStatues == AuthRequestStatues.authSuccess) {
              authBloc.add(
                AccessTokenCacheEvent(
                  accessToken: state.loginModel!.token,
                  isLogin: true,
                ),
              );
            }
            if (state.loginRequestStatues == AuthRequestStatues.cachedSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutesNames.mainLayout, (route) => false);
              accessTokenVar = state.loginModel!.token;
            }
            if (state.loginRequestStatues == AuthRequestStatues.error) {
              flutterToast(
                  msg: state.errorMessage,
                  backgroundColor: AppColors.toastError,
                  textColor: AppColors.white);
            }
          },
          builder: (context, state) {
            switch (state.loginRequestStatues) {
              case AuthRequestStatues.idle:
                return const LoginButtonDesign();
              case AuthRequestStatues.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AuthRequestStatues.authSuccess:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case AuthRequestStatues.error:
                return const LoginButtonDesign();

              case AuthRequestStatues.cachedSuccess:
                return Text(
                  'Login Success',
                  style: Theme.of(context).textTheme.titleLarge,
                );
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const DontHaveAccountWidget(),
      ],
    );
  }
}
