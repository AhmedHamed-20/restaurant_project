import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/oldlayouts/admin_layout/admin_layout_screen.dart';
import 'package:resturant/oldlayouts/user_layout/user_layout_screen.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/screens/user_screens/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'models/bloc/cubits/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachFunc.init();
  String token = CachFunc.getData('token');
  String isAdmin = CachFunc.getData('isAdmin');
  if (await CachFunc.getBoolDate(key: 'isDark') == null) {
    EndPoints.isDark = false;
  } else {
    EndPoints.isDark = await CachFunc.getBoolDate(key: 'isDark');
  }

  print(token);

  runApp(MyApp(token, isAdmin));
}

class MyApp extends StatelessWidget {
  String token;
  String isAdmin;
  MyApp(this.token, this.isAdmin);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => Appcubit()
            ..dataBase()
            ..getdata(context, token: token)
            ..checkConnecthion(),
        ),
        BlocProvider(create: (BuildContext context) => AdminCubit()),
      ],
      child: BlocConsumer<Appcubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Appcubit.get(context);
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.orangeAccent,
              primaryColorDark: Colors.orangeAccent,
            ),
            debugShowCheckedModeBanner: false,
            title: 'Panda Restaurant',
            home: SplashScreenView(
              navigateRoute: token == null
                  ? LoginScreen()
                  : isAdmin == null
                      ? LayoutScreen(
                          token: token,
                        )
                      : AdminLayout(),
              backgroundColor: Colors.orange,
              imageSrc: 'assets/images/restaurant.png',
              imageSize: 130,
              duration: 4000,
              text: 'Panda Restaurant',
              textType: TextType.TyperAnimatedText,
              textStyle: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontFamily: 'Batka',
              ),
            ),
          );
        },
      ),
    );
  }
}
