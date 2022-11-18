import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/user/Auth/view/widgets/sign_up_widgets/sign_up_button_design.dart';

import '../../../../../../core/const/app_routes_names.dart';
import '../../../../../../core/const/const.dart';
import '../../../../../../core/utls/utls.dart';
import '../../../view_model/bloc/auth_bloc.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Column(
      children: [
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.signUpRequestStatues == AuthRequestStatues.authSuccess) {
              authBloc.add(AccessTokenCacheEvent(
                  accessToken: state.signUpModel!.token, isLogin: false));
            }
            if (state.signUpRequestStatues ==
                AuthRequestStatues.cachedSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutesNames.mainLayout, (route) => false);
            }
            if (state.signUpRequestStatues == AuthRequestStatues.error) {
              flutterToast(
                  msg: state.errorMessage,
                  backgroundColor: AppColors.toastError,
                  textColor: AppColors.white);
            }
          },
          builder: (context, state) {
            switch (state.signUpRequestStatues) {
              case AuthRequestStatues.idle:
                return const SignUpButtonDesign();
              case AuthRequestStatues.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AuthRequestStatues.authSuccess:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case AuthRequestStatues.error:
                return const SignUpButtonDesign();
              case AuthRequestStatues.cachedSuccess:
                return Text(
                  'SignUp Success',
                  style: Theme.of(context).textTheme.titleLarge,
                );
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have account?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutesNames.loginScreen);
              },
              child: Text(
                'Login',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
