import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/core/const/text_editing_controllers.dart';
import 'package:resturant/core/widget/defaults.dart';
import 'package:resturant/features/user/Auth/view/widgets/sign_up_widgets/sign_up_buttons_widget.dart';

import '../../../../../../core/const/const.dart';

class SignUpMainWidget extends StatelessWidget {
  const SignUpMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.7,
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r25),
          topRight: Radius.circular(AppRadius.r25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 60,
              top: 10,
            ),
            child: Text(
              'Login',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Defaults.defaultTextField(
            context: context,
            controller: TextEditingControllers.signUpNameController,
            title: 'Name',
            prefixIcon: Icon(
              Icons.text_fields_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultTextField(
            context: context,
            controller: TextEditingControllers.signUpEmailController,
            title: 'Email',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultTextField(
            context: context,
            controller: TextEditingControllers.signUpPasswordController,
            title: 'Password',
            prefixIcon: Icon(IconlyLight.lock,
                color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultTextField(
            context: context,
            controller: TextEditingControllers.signUpPasswordConfirmController,
            title: 'Confirm Password',
            prefixIcon: Icon(IconlyLight.lock,
                color: Theme.of(context).iconTheme.color),
          ),
          const SizedBox(
            height: AppHeight.h10,
          ),
          const SignUpButtonWidget(),
        ],
      ),
    );
  }
}
