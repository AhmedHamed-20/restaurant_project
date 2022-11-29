import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/layout/user/view_model/bloc/layout_bloc.dart';

class MainLayoutAdmin extends StatelessWidget {
  const MainLayoutAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.transparentColor,
        title: BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, state) {
            return Text(
              layoutBloc.titlesAdminLayout[state.currentIndexAdminPanel],
              style: Theme.of(context).textTheme.titleLarge,
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<LayoutBloc, LayoutState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: Theme.of(context).backgroundColor,
            onTap: (index) {
              layoutBloc.add(CurrentIndexAdminPanelChangeEvent(index));
            },
            currentIndex: state.currentIndexAdminPanel,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).backgroundColor,
                icon: const Icon(Icons.people),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).backgroundColor,
                icon: const Icon(Icons.food_bank),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).backgroundColor,
                icon: const Icon(Icons.category),
                label: 'Caeegories',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).backgroundColor,
                icon: const Icon(Icons.shopping_cart),
                label: 'Orders',
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<LayoutBloc, LayoutState>(
        builder: (context, state) {
          return layoutBloc.adminScreens[state.currentIndexAdminPanel];
        },
      ),
    );
  }
}
