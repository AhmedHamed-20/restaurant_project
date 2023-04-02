import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/cache/chache_setup.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/database/date_base_service.dart';
import 'package:resturant/core/routes/app_router.dart';
import 'package:resturant/core/services/service_locator.dart';
import 'package:resturant/core/theme/app_theme.dart';
import 'package:resturant/features/user/Auth/view_model/bloc/auth_bloc.dart';
import 'package:resturant/features/user/Recipes/view_model/bloc/recipes_bloc.dart';

import 'core/layout/user/view_model/bloc/layout_bloc.dart';
import 'features/admin/Auth/view_model/bloc/admin_auth_bloc.dart';
import 'features/user/Orders/view_model/bloc/orders_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.initDio();
  ServiceLocator.init();
  ServiceLocator.initDataBase();
  await ServiceLocator.initCacheHelper();
  await serviceLocator<DataBaseService>().init(
      databasesName: 'favorite.db',
      version: 1,
      query:
          'CREATE TABLE favorite (id INTEGER PRIMARY KEY, userId TEXT,name TEXT, imageCover TEXT, price INTEGER, slug TEXT,recipeId TEXT,category TEXT,cookingTime INTEGER,ingredients TEXT)');
  final String accessToken =
      await serviceLocator<CacheService>().getData(key: 'accessToken') ?? '';
  runApp(MyApp(
    appRouter: AppRouter(),
    accessToken: accessToken,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter, required this.accessToken});
  final AppRouter appRouter;
  final String accessToken;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    accessTokenVar = accessToken;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AdminAuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<RecipesBloc>()
            ..add(
              const AllRecipesGetEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<LayoutBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<OrdersBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightMode,
        darkTheme: AppTheme.darkMode,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'Panda Restaurant',
        onGenerateRoute: appRouter.generateRoutes,
        initialRoute: accessToken == ''
            ? AppRoutesNames.loginScreen
            : AppRoutesNames.mainLayout,
      ),
    );
  }
}
