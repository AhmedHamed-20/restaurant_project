import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/layout/user/view_model/bloc/layout_bloc.dart';

import '../../../../../utls/utls.dart';
import '../../widgets/layout_main_widget.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LayoutBloc>(context)
        .add(ActiveUserDataGetEvent(accessTokenVar));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) {
        switch (state.layoutRequestStatues) {
          case LayoutRequestStatues.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LayoutRequestStatues.success:
            return const LayoutMainWidget();
          case LayoutRequestStatues.error:
            return Scaffold(
              body: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
        }
      },
    );
  }
}
