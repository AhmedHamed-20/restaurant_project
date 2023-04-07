import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/base_recipes_data_model.dart';
import 'package:resturant/core/layout/user/view/screens/user/main_layout_screen.dart';
import 'package:resturant/features/admin/AllRecipes/view/screens/create_new_recipe_screen.dart';
import 'package:resturant/features/admin/AllRecipes/view_model/bloc/recipes_admin_bloc.dart';
import 'package:resturant/features/admin/AllUsers/view/screens/all_users_admin_screen.dart';
import 'package:resturant/features/user/Auth/view/screens/forget_password.dart';
import 'package:resturant/features/user/Auth/view/screens/login_screen.dart';
import 'package:resturant/features/user/Auth/view/screens/sign_up_screen.dart';

import '../../features/admin/AllRecipes/view/screens/recipe_details_admin_screen.dart';
import '../../features/admin/Auth/view/screens/login_admin_screen.dart';
import '../../features/user/Categories/view/screens/category_recipes.dart';
import '../../features/user/Recipes/view/screens/home_screen.dart';
import '../../features/user/Recipes/view/screens/recipe_details_screen.dart';
import '../const/app_routes_names.dart';
import '../const/params.dart';
import '../layout/user/view/screens/admin/main_layout_admin.dart';
import '../layout/user/view/screens/user/active_user_data_info_screen.dart';
import '../layout/user/view/screens/user/splash_screen.dart';

class AppRouter {
  Route? generateRoutes(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutesNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScrenn());

      case AppRoutesNames.loginAdminScreen:
        return MaterialPageRoute(builder: (_) => const LoginAdminScreen());
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
        BaseRecipesDataModel argumnet = args as BaseRecipesDataModel;
        return MaterialPageRoute(
          builder: (_) => RecipeDetailsScreen(
            recipeDataModel: argumnet,
          ),
        );
      case AppRoutesNames.categoryRecipesScreen:
        final argumnet = args as CategoryRecipesScreenParams;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: argumnet.categoriesBloc,
              child: CategoryRecipes(
                categoryName: argumnet.categoryName,
                categoriesBloc: argumnet.categoriesBloc,
              )),
        );

      case AppRoutesNames.adminLayout:
        return MaterialPageRoute(
          builder: (_) => const MainLayoutAdmin(),
        );
      case AppRoutesNames.activeUserDataInfoScreen:
        return MaterialPageRoute(
          builder: (_) => const ActiveUserDataInfoScreen(),
        );

      case AppRoutesNames.allUsers:
        return MaterialPageRoute(
          builder: (_) => const AllUsersAdminScrenn(),
        );
      case AppRoutesNames.recipeAdminDetailsScreen:
        DetailAdminScreenParams argumnet = args as DetailAdminScreenParams;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: argumnet.recipesBloc,
              child: RecipeDetailsAdminScreen(
                  recipeDataModel: argumnet.recipeDataAdminModel)),
        );
      case AppRoutesNames.addNewRecipeScreen:
        RecipesAdminBloc argumnet = args as RecipesAdminBloc;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: argumnet, child: const CreateNewRecipeScreen()),
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
