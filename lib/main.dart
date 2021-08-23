import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/screens/login_screen.dart';

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
          create: (BuildContext context) => Appcubit()..dataBase(),
        ),
      ],
      child: BlocConsumer<Appcubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: token == null ? LoginScreen() : LayoutScreen(),
          );
        },
      ),
    );
  }
}
