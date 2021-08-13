import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/layouts/layout_screen.dart';
import 'package:resturant/models/bloc/states/states.dart';

import 'models/bloc/cubits/cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => Appcubit(),
        ),
      ],
      child: BlocConsumer<Appcubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: LayoutScreen(),
          );
        },
      ),
    );
  }
}
