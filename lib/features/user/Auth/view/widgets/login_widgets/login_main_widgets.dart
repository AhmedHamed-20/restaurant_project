import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/core/widget/defaults.dart';

import '../../../../../../core/const/const.dart';
import '../../../../../../core/const/text_editing_controllers.dart';
import '../../../view_model/bloc/auth_bloc.dart';
import 'login_buttons_widget.dart';

class LoginMainWidget extends StatelessWidget {
  const LoginMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Container(
      height: screenHeight(context) * 0.7,
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r25),
          topRight: Radius.circular(AppRadius.r25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 60,
              top: 10,
            ),
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Defaults.defaultTextField(
            context: context,
            controller: TextEditingControllers.loginEmailController,
            title: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Defaults.defaultTextField(
                obscureText: state.loginPasswordVisibility,
                suffixIcon: IconButton(
                  onPressed: () {
                    authBloc.add(LoginPasswordVisibilityEvent(
                        loginPasswordVisibility:
                            !state.loginPasswordVisibility));
                  },
                  icon: Icon(
                    state.loginPasswordVisibility
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                context: context,
                controller: TextEditingControllers.loginPasswordController,
                title: 'Password',
                prefixIcon: Icon(IconlyLight.lock,
                    color: Theme.of(context).iconTheme.color),
              );
            },
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          const LoginButtonsWidget(),
          const SizedBox(
            height: AppHeight.h10,
          ),
        ],
      ),
    );
  }
}
