import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/const.dart';
import '../../../../../../core/const/text_editing_controllers.dart';
import '../../../view_model/bloc/auth_bloc.dart';

class SignUpButtonDesign extends StatelessWidget {
  const SignUpButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
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
          SignUpEvent(
            passwordConfirmation: TextEditingControllers
                .signUpPasswordConfirmController.text
                .trim(),
            email: TextEditingControllers.signUpEmailController.text.trim(),
            password:
                TextEditingControllers.signUpPasswordController.text.trim(),
            name: TextEditingControllers.signUpNameController.text.trim(),
          ),
        );
      },
      child: Text(
        'SignUp',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.white),
      ),
    );
  }
}
