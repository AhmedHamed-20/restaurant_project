import 'package:flutter/material.dart';

import '../../../../../../core/const/app_routes_names.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'don\'t have account?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutesNames.signUpScreen);
          },
          child: Text(
            'SignUp',
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
