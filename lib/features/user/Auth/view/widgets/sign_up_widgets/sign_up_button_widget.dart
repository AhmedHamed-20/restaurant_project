import 'package:flutter/material.dart';

import '../../../../../../core/const/app_routes_names.dart';
import '../../../../../../core/const/const.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              'SignUp',
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
              'Already have account?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutesNames.loginScreen);
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
        ),
      ],
    );
  }
}
