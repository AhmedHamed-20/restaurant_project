import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/const.dart';
import '../../../../../../core/const/text_editing_controllers.dart';
import '../../../../../../core/utls/utls.dart';
import '../../../view_model/bloc/auth_bloc.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.forgetPasswordRequestStatues ==
            ForgetPasswordRequestStatues.success) {
          flutterToast(
              msg: 'Check your email to reset your password',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
        }
        if (state.forgetPasswordRequestStatues ==
            ForgetPasswordRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
        }
      },
      builder: (context, state) {
        switch (state.forgetPasswordRequestStatues) {
          case ForgetPasswordRequestStatues.idle:
            return MaterialButton(
              minWidth: double.infinity,
              height: AppHeight.h46,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r25),
              ),
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(AppPadding.p12),
              onPressed: () {
                authBloc.add(
                  ForgetPasswordEvent(
                    email: TextEditingControllers
                        .forgetPasswordEmailController.text
                        .trim(),
                  ),
                );
              },
              child: Text(
                'Send',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.white),
              ),
            );
          case ForgetPasswordRequestStatues.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ForgetPasswordRequestStatues.success:
            return MaterialButton(
              minWidth: double.infinity,
              height: AppHeight.h46,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r25),
              ),
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(AppPadding.p12),
              onPressed: () {
                authBloc.add(
                  ForgetPasswordEvent(
                    email: TextEditingControllers
                        .forgetPasswordEmailController.text
                        .trim(),
                  ),
                );
              },
              child: Text(
                'Send',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.white),
              ),
            );

          case ForgetPasswordRequestStatues.error:
            return MaterialButton(
              minWidth: double.infinity,
              height: AppHeight.h46,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r25),
              ),
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(AppPadding.p12),
              onPressed: () {
                authBloc.add(
                  ForgetPasswordEvent(
                    email: TextEditingControllers
                        .forgetPasswordEmailController.text
                        .trim(),
                  ),
                );
              },
              child: Text(
                'Send',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.white),
              ),
            );
        }
      },
    );
  }
}
