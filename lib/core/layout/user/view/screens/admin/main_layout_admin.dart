import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/layout/user/view_model/bloc/layout_bloc.dart';

class MainLayoutAdmin extends StatelessWidget {
  const MainLayoutAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).backgroundColor,
        onTap: (index) {
          layoutBloc.add(CurrentIndexAdminPanelChangeEvent(index));
        },
        currentIndex: 0,
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
            icon: const Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
        ],
      ),
      body: BlocBuilder<LayoutBloc, LayoutState>(
        builder: (context, state) {
          return layoutBloc.adminScreens[state.currentIndexAdminPanel];
        },
      ),
    );
  }
}
