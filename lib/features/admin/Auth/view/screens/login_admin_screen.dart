import 'package:flutter/material.dart';

import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/Auth/view/widgets/login_admin_main_widgets.dart';

class LoginAdminScreen extends StatelessWidget {
  const LoginAdminScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight(context) * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login2.png'),
                  ),
                ),
              ),
              const LoginAdminMainWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
