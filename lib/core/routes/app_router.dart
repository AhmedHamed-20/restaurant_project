import 'package:flutter/material.dart';
import 'package:resturant/core/layout/view/screens/main_layout_screen.dart';
import 'package:resturant/features/user/Auth/view/screens/forget_password.dart';
import 'package:resturant/features/user/Auth/view/screens/login_screen.dart';
import 'package:resturant/features/user/Auth/view/screens/sign_up_screen.dart';

import '../../features/user/Recipes/models/recipe_data_model.dart';
import '../../features/user/Recipes/view/screens/home_screen.dart';
import '../../features/user/Recipes/view/screens/recipe_details_screen.dart';
import '../const/app_routes_names.dart';
import '../layout/view/screens/splash_screen.dart';

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
      case AppRoutesNames.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRoutesNames.mainLayout:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(),
        );
      case AppRoutesNames.detailsScreen:
        RecipeDataModel argumnet = args as RecipeDataModel;
        return MaterialPageRoute(
          builder: (_) => RecipeDetailsScreen(recipeDataModel: argumnet),
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
