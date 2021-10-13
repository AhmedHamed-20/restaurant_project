import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/screens/user_screens/user_account_screen.dart';
import 'package:resturant/widgets/navigate.dart';

class AdminLayout extends StatelessWidget {
  var token;
  AdminLayout({this.token});
  // Map<String, dynamic> userDate;
  // LayoutScreen(this.userDate);
  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    cubit.checkConnecthion();
    return BlocConsumer<AdminCubit, AdminState>(
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
            backgroundColor:
                cubit.isDark ? Color(0xff222831) : Colors.grey[200],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.orangeAccent,
              unselectedItemColor: Colors.grey,
              backgroundColor: cubit.isDark ? Color(0xff222831) : Colors.white,
              onTap: (index) {
                cubit.changBottomnav(index);
              },
              currentIndex: cubit.currentindex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor:
                      cubit.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 0
                      ? Icon(IconlyBold.user3)
                      : Icon(IconlyBroken.user3),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      cubit.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 1
                      ? Icon(Icons.restaurant_menu)
                      : Icon(Icons.restaurant_menu),
                  label: 'Recipes',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      cubit.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 2
                      ? Icon(IconlyBold.category)
                      : Icon(IconlyBroken.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      cubit.isDark ? Color(0xff222831) : Colors.white,
                  icon: cubit.currentindex == 3
                      ? Icon(IconlyBold.buy)
                      : Icon(IconlyBroken.buy),
                  label: 'Orders',
                ),
              ],
            ),
            appBar: AppBar(
              leading: MaterialButton(
                onPressed: () {
                  cubit.changeTheme();
                },
                child: Icon(
                  cubit.isDark ? Icons.wb_sunny : Icons.dark_mode,
                  color: cubit.isDark ? Colors.white : Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                '${cubit.title[cubit.currentindex]}',
                style: TextStyle(
                  color: cubit.isDark ? Colors.white : Colors.grey[800],
                  fontFamily: 'Batka',
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 7),
                  child: InkWell(
                    onTap: () {
                      cubit.result
                          ? Navigate(Screen: UserAccount(), context: context)
                          : SizedBox();
                    },
                    child: cubit.result
                        ? DataBaseFun.storedData == null
                            ? CircularProgressIndicator(
                                strokeWidth: 1,
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  DataBaseFun.storedData[0]['photourl'],
                                ),
                                //   backgroundImage: ,
                              )
                        : CircleAvatar(
                            radius: 20,
                          ),
                  ),
                ),
              ],
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            body: cubit.result
                ? cubit.screen[cubit.currentindex]
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No internet',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Batka',
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Batka',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
