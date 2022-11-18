import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/const.dart';
import '../../../../../../core/const/text_editing_controllers.dart';
import '../../../view_model/bloc/auth_bloc.dart';

class LoginButtonDesign extends StatelessWidget {
  const LoginButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return MaterialButton(
      minWidth: double.infinity,
      height: AppHeight.h46,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r25)),
      padding: const EdgeInsets.all(AppPadding.p12),
      onPressed: () {
        authBloc.add(
          LoginEvent(
            email: TextEditingControllers.loginEmailController.text.trim(),
            password:
                TextEditingControllers.loginPasswordController.text.trim(),
          ),
        );
      },
      child: Text(
        'Login',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.white),
      ),
    );
  }
}
