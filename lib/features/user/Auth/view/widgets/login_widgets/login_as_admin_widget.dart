import 'package:flutter/material.dart';

import '../../../../../../core/const/app_routes_names.dart';

class LoginAsAdminWidget extends StatelessWidget {
  const LoginAsAdminWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutesNames.loginAdminScreen);
      },
      child: Text(
        'Login As Admin',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
