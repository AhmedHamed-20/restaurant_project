import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/screens/login_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'models/bloc/cubits/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachFunc.init();
  String token = CachFunc.getData('token');
  print(token);

  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  String token;

  MyApp(this.token);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => Appcubit()
            ..dataBase()
            ..getdata(context)
            ..checkConnecthion(),
        ),
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
                  : LayoutScreen(
                      token: token,
                    ),
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
