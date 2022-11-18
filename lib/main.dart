import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/network/dio.dart';
import 'package:resturant/core/routes/app_router.dart';
import 'package:resturant/core/services/service_locator.dart';
import 'package:resturant/core/theme/app_theme.dart';
import 'package:resturant/features/user/Auth/view/screens/login_screen.dart';
import 'package:resturant/features/user/Auth/view_model/bloc/auth_bloc.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  ServiceLocator.init();

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightMode,
        darkTheme: AppTheme.darkMode,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'Panda Restaurant',
        onGenerateRoute: appRouter.generateRoutes,
        initialRoute: AppRoutesNames.splashScreen,
      ),
    );
  }
}
