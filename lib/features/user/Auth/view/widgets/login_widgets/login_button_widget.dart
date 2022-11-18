import 'package:flutter/material.dart';
import 'package:resturant/core/const/app_routes_names.dart';

import '../../../../../../core/const/const.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AppRoutesNames.forgetPasswordScreen);
            },
            child: Text(
              'Forget your password ?',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.orangeAccent),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(25),
          ),
          width: double.infinity,
          child: MaterialButton(
            padding: const EdgeInsets.all(AppPadding.p12),
            onPressed: () {},
            child: Text(
              'Login',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.white),
            ),
          ),
          //
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
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
            )
          ],
        )
      ],
    );
  }
}
