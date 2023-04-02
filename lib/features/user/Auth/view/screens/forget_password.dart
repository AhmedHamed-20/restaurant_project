import 'package:flutter/material.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/widget/defaults.dart';

import '../../../../../core/const/text_editing_controllers.dart';
import '../widgets/forget_password_widgets/forget_password_button_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text('Forget Password',
            style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/forget.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: AppHeight.h22,
            ),
            Container(
              padding: const EdgeInsets.all(AppPadding.p20),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppRadius.r25),
                  topLeft: Radius.circular(AppRadius.r25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your email',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: AppHeight.h20,
                  ),
                  Defaults.defaultTextField(
                    context: context,
                    controller:
                        TextEditingControllers.forgetPasswordEmailController,
                    title: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  const SizedBox(
                    height: AppHeight.h10,
                  ),
                  const ForgetPasswordButtonWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
