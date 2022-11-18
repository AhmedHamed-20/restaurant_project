import 'package:flutter/material.dart';
import 'package:resturant/features/user/Auth/view/screens/forget_password.dart';
import 'package:resturant/features/user/Auth/view/screens/login_screen.dart';
import 'package:resturant/features/user/Auth/view/screens/sign_up_screen.dart';

import '../const/app_routes_names.dart';
import '../layout/view/splash_screen.dart';

class AppRouter {
  Route? generateRoutes(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutesNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScrenn());
      case AppRoutesNames.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRoutesNames.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case AppRoutesNames.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('no Routes'),
            ),
          ),
        );
    }
  }
}
