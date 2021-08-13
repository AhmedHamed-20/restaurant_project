import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/screens/search_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            cubit.changBottomnav(0);
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.orangeAccent,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                cubit.changBottomnav(index);
              },
              currentIndex: cubit.currentindex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline),
                  label: 'Favorites',
                ),
              ],
            ),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                '${cubit.title[cubit.currentindex]}',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: 'Batka',
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[800],
                  ),
                  onPressed: () {
                    Navigate(
                      context: context,
                      Screen: SearchScrean(),
                    );
                  },
                )
              ],
              elevation: 0,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: cubit.screen[cubit.currentindex],
          ),
        );
      },
    );
  }
}
