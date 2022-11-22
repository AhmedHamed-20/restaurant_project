import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../const/const.dart';
import '../../../../const/text_editing_controllers.dart';
import '../../../../utls/utls.dart';
import '../../../../widget/defaults.dart';
import '../../view_model/bloc/layout_bloc.dart';

class ChangePasswordButtonWidget extends StatelessWidget {
  const ChangePasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return BlocConsumer<LayoutBloc, LayoutState>(
      listener: (context, state) {
        if (state.changePasswordRequestStatues ==
            ActiveUserUpdatePasswordRequestStatues.accessTokenGetSuccess) {
          Navigator.of(context).pop();
          TextEditingControllers.activeUserDataOldPasswordController.clear();
          TextEditingControllers.activeUserDataPasswordController.clear();
          TextEditingControllers.activeUserDataPasswordConfirmController
              .clear();
          flutterToast(
              msg: 'Password Updated',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
        }
        if (state.changePasswordRequestStatues ==
            ActiveUserUpdatePasswordRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
        }
      },
      builder: (context, state) {
        switch (state.changePasswordRequestStatues) {
          case ActiveUserUpdatePasswordRequestStatues.idle:
            return Defaults.defaultButton(
              context: context,
              title: 'Change Password',
              onPressed: () {
                layoutBloc.add(
                  PasswordActiveUserUpdateEvent(
                    accessToken: accessTokenVar,
                    confirmPassword: TextEditingControllers
                        .activeUserDataPasswordConfirmController.text,
                    newPassword: TextEditingControllers
                        .activeUserDataPasswordController.text,
                    oldPassword: TextEditingControllers
                        .activeUserDataOldPasswordController.text,
                  ),
                );
              },
            );
          case ActiveUserUpdatePasswordRequestStatues.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ActiveUserUpdatePasswordRequestStatues.passwordUpdatedSuccess:
            return Column(children: const [
              Text('Almost Done!'),
              SizedBox(
                height: AppHeight.h4,
              ),
              CircularProgressIndicator(),
            ]);
          case ActiveUserUpdatePasswordRequestStatues.accessTokenCachedSuccess:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ActiveUserUpdatePasswordRequestStatues.accessTokenGetSuccess:
            return Defaults.defaultButton(
              context: context,
              title: 'Change Password',
              onPressed: () {
                layoutBloc.add(
                  PasswordActiveUserUpdateEvent(
                    accessToken: accessTokenVar,
                    confirmPassword: TextEditingControllers
                        .activeUserDataPasswordConfirmController.text,
                    newPassword: TextEditingControllers
                        .activeUserDataPasswordController.text,
                    oldPassword: TextEditingControllers
                        .activeUserDataOldPasswordController.text,
                  ),
                );
              },
            );
          case ActiveUserUpdatePasswordRequestStatues.error:
            return Defaults.defaultButton(
              context: context,
              title: 'Change Password',
              onPressed: () {
                layoutBloc.add(
                  PasswordActiveUserUpdateEvent(
                    accessToken: accessTokenVar,
                    confirmPassword: TextEditingControllers
                        .activeUserDataPasswordConfirmController.text,
                    newPassword: TextEditingControllers
                        .activeUserDataPasswordController.text,
                    oldPassword: TextEditingControllers
                        .activeUserDataOldPasswordController.text,
                  ),
                );
              },
            );
        }
      },
    );
  }
}
