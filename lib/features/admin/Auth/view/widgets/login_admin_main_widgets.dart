import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/core/widget/defaults.dart';

import '../../../../../../core/const/const.dart';
import '../../../../../../core/const/text_editing_controllers.dart';
import '../../view_model/bloc/admin_auth_bloc.dart';
import 'login_admin_buttons_widget.dart';

class LoginAdminMainWidget extends StatelessWidget {
  const LoginAdminMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var adminAuthBloc = BlocProvider.of<AdminAuthBloc>(context);
    return Container(
      height: screenHeight(context) * 0.7,
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
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
              'Login As Admin',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Defaults.defaultTextField(
            context: context,
            controller: TextEditingControllers.loginEmailAdminController,
            title: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          BlocBuilder<AdminAuthBloc, AdminAuthState>(
            builder: (context, state) {
              return Defaults.defaultTextField(
                obscureText: state.loginAdminPasswordVisibility,
                suffixIcon: IconButton(
                  onPressed: () {
                    adminAuthBloc.add(LoginAdminPasswordVisibiltyEvent(
                        loginAdminPasswordVisibility:
                            !state.loginAdminPasswordVisibility));
                  },
                  icon: Icon(
                    state.loginAdminPasswordVisibility
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                context: context,
                controller: TextEditingControllers.loginPasswordAdminController,
                title: 'Password',
                prefixIcon: Icon(IconlyLight.lock,
                    color: Theme.of(context).iconTheme.color),
              );
            },
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          const LoginAdminButtonsWidget(),
        ],
      ),
    );
  }
}
