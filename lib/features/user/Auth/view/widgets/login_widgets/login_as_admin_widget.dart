import 'package:flutter/material.dart';

import '../../../../../../core/const/app_routes_names.dart';

class LoginAsAdminWidget extends StatelessWidget {
  const LoginAsAdminWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Continue as admin ?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutesNames.loginAdminScreen);
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
    );
  }
}
