import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/widget/defaults.dart';
import 'package:resturant/features/admin/Auth/view_model/bloc/admin_auth_bloc.dart';

import '../../../../../core/const/text_editing_controllers.dart';

class LoginAdminButtonDesign extends StatelessWidget {
  const LoginAdminButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    var adminAuthBloc = BlocProvider.of<AdminAuthBloc>(context);
    return Defaults.defaultButton(
        context: context,
        title: 'Login',
        onPressed: () {
          adminAuthBloc.add(LoginAdminEvent(
              TextEditingControllers.loginEmailAdminController.text.trim(),
              TextEditingControllers.loginPasswordAdminController.text));
        });
  }
}
