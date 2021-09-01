import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/screens/search_screen.dart';
import 'package:resturant/screens/user_account_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class LayoutScreen extends StatelessWidget {
  var token;
  LayoutScreen({this.token});
  // Map<String, dynamic> userDate;
  // LayoutScreen(this.userDate);
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (token != null) {
        //   cubit.getdata();
        // }
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
                  icon: Icon(IconlyBroken.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.buy),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.bag),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.heart),
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
                ),
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: InkWell(
                    onTap: () {
                      Navigate(Screen: UserAccount(), context: context);
                    },
                    child: DataBaseFun.storedData.isEmpty
                        ? CircularProgressIndicator(
                            strokeWidth: 1,
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              DataBaseFun.storedData[0]['photourl'],
                            ),
                            //   backgroundImage: ,
                          ),
                  ),
                ),
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
