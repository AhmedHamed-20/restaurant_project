import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../const/const.dart';
import '../../../../const/text_editing_controllers.dart';
import '../../../../widget/defaults.dart';
import '../../view_model/bloc/layout_bloc.dart';
import 'change_password_button.dart';

class ChangePasswordBottomSheetWidget extends StatelessWidget {
  const ChangePasswordBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.p20,
        right: AppPadding.p20,
        top: AppPadding.p20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: screenHeight(context) * 0.6,
        child: Column(
          children: [
            Text(
              'Change Password',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            BlocBuilder<LayoutBloc, LayoutState>(
              builder: (context, state) {
                return Defaults.defaultTextField(
                  suffixIcon: IconButton(
                    onPressed: () {
                      layoutBloc.add(
                        PasswordVisibiltyChangeEvent(
                          !state.passwordVisibilty,
                        ),
                      );
                    },
                    icon: Icon(
                      state.passwordVisibilty
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  obscureText: state.passwordVisibilty,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  context: context,
                  controller: TextEditingControllers
                      .activeUserDataOldPasswordController,
                  title: 'Old Password',
                );
              },
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            BlocBuilder<LayoutBloc, LayoutState>(
              builder: (context, state) {
                return Defaults.defaultTextField(
                  suffixIcon: IconButton(
                    onPressed: () {
                      layoutBloc.add(
                        PasswordVisibiltyChangeEvent(
                          !state.passwordVisibilty,
                        ),
                      );
                    },
                    icon: Icon(
                      state.passwordVisibilty
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  obscureText: state.passwordVisibilty,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  context: context,
                  controller:
                      TextEditingControllers.activeUserDataPasswordController,
                  title: 'New Password',
                );
              },
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            BlocBuilder<LayoutBloc, LayoutState>(
              builder: (context, state) {
                return Defaults.defaultTextField(
                  suffixIcon: IconButton(
                    onPressed: () {
                      layoutBloc.add(
                        PasswordVisibiltyChangeEvent(
                          !state.passwordVisibilty,
                        ),
                      );
                    },
                    icon: Icon(
                      state.passwordVisibilty
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  obscureText: state.passwordVisibilty,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  context: context,
                  controller: TextEditingControllers
                      .activeUserDataPasswordConfirmController,
                  title: 'Confirm Password',
                );
              },
            ),
            const SizedBox(
              height: AppHeight.h20,
            ),
            const ChangePasswordButtonWidget(),
          ],
        ),
      ),
    );
  }
}
