import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/layout/view_model/bloc/layout_bloc.dart';

import '../../../utls/utls.dart';
import '../widgets/layout_main_widget.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

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