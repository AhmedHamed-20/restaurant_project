// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:resturant/models/bloc/cubits/cubit.dart';
// import 'package:resturant/models/bloc/states/states.dart';
// import 'package:resturant/models/databasae/database.dart';
// import 'package:resturant/models/dio/end_points.dart';
// import 'package:resturant/screens/user_screens/search_screen.dart';
// import 'package:resturant/screens/user_screens/user_account_screen.dart';
// import 'package:resturant/widgets/navigate.dart';

// class LayoutScreen extends StatelessWidget {
//   var token;
//   LayoutScreen({this.token});
//   // Map<String, dynamic> userDate;
//   // LayoutScreen(this.userDate);
//   @override
//   Widget build(BuildContext context) {
//     var cubit = Appcubit.get(context);
//     cubit.checkConnecthion();
//     return BlocConsumer<Appcubit, AppState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         // if (token != null) {
//         //   cubit.getdata();
//         // }
//         return WillPopScope(
//           onWillPop: () async {
//             cubit.changBottomnav(0);
//             return false;
//           },
//           child: Scaffold(
//             backgroundColor:
//                 EndPoints.isDark ? Color(0xff222831) : Colors.grey[100],
//             bottomNavigationBar: BottomNavigationBar(
//               selectedItemColor: Colors.orangeAccent,
//               unselectedItemColor: Colors.grey,
//               backgroundColor:
//                   EndPoints.isDark ? Color(0xff222831) : Colors.white,
//               onTap: (index) {
//                 cubit.changBottomnav(index);
//               },
//               currentIndex: cubit.currentindex,
//               items: [
//                 BottomNavigationBarItem(
//                   backgroundColor:
//                       EndPoints.isDark ? Color(0xff222831) : Colors.white,
//                   icon: cubit.currentindex == 0
//                       ? Icon(IconlyBold.home)
//                       : Icon(IconlyBroken.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   backgroundColor:
//                       EndPoints.isDark ? Color(0xff222831) : Colors.white,
//                   icon: cubit.currentindex == 1
//                       ? Icon(IconlyBold.category)
//                       : Icon(IconlyBroken.category),
//                   label: 'Categories',
//                 ),
//                 BottomNavigationBarItem(
//                   backgroundColor:
//                       EndPoints.isDark ? Color(0xff222831) : Colors.white,
//                   icon: cubit.currentindex == 2
//                       ? Icon(IconlyBold.buy)
//                       : Icon(IconlyBroken.buy),
//                   label: 'Cart',
//                 ),
//                 BottomNavigationBarItem(
//                   backgroundColor:
//                       EndPoints.isDark ? Color(0xff222831) : Colors.white,
//                   icon: cubit.currentindex == 3
//                       ? Icon(IconlyBold.bag)
//                       : Icon(IconlyBroken.bag),
//                   label: 'Orders',
//                 ),
//                 BottomNavigationBarItem(
//                   backgroundColor:
//                       EndPoints.isDark ? Color(0xff222831) : Colors.white,
//                   icon: cubit.currentindex == 4
//                       ? Icon(IconlyBold.heart)
//                       : Icon(IconlyBroken.heart),
//                   label: 'Favorites',
//                 ),
//               ],
//             ),
//             appBar: AppBar(
//               leading: MaterialButton(
//                 onPressed: () {
//                   cubit.changeTheme();
//                 },
//                 child: Icon(
//                   EndPoints.isDark ? Icons.wb_sunny : Icons.dark_mode,
//                   color: EndPoints.isDark
//                       ? Colors.white
//                       : EndPoints.isDark
//                           ? Colors.white
//                           : Colors.black,
//                 ),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.transparent,
//               title: Text(
//                 '${cubit.title[cubit.currentindex]}',
//                 style: TextStyle(
//                   color: EndPoints.isDark ? Colors.white : Colors.grey[800],
//                   fontFamily: 'Batka',
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     color: EndPoints.isDark ? Colors.white : Colors.grey[800],
//                   ),
//                   onPressed: () {
//                     cubit.result
//                         ? Navigate(
//                             context: context,
//                             Screen: SearchScrean(),
//                           )
//                         : SizedBox();
//                   },
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 7),
//                   child: InkWell(
//                     onTap: () {
//                       cubit.result
//                           ? Navigate(Screen: UserAccount(), context: context)
//                           : SizedBox();
//                     },
//                     child: cubit.result
//                         ? DataBaseFun.storedData == null
//                             ? CircularProgressIndicator(
//                                 strokeWidth: 1,
//                               )
//                             : CircleAvatar(
//                                 radius: 20,
//                                 backgroundImage: NetworkImage(
//                                   DataBaseFun.storedData[0]['photourl'],
//                                 ),
//                                 //   backgroundImage: ,
//                               )
//                         : CircleAvatar(
//                             radius: 20,
//                           ),
//                   ),
//                 ),
//               ],
//               elevation: 0,
//               systemOverlayStyle: SystemUiOverlayStyle(
//                 statusBarIconBrightness: Brightness.light,
//               ),
//             ),
//             body: cubit.result
//                 ? cubit.screen[cubit.currentindex]
//                 : Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'No internet',
//                           style: TextStyle(
//                             color:
//                                 EndPoints.isDark ? Colors.white : Colors.black,
//                             fontFamily: 'Batka',
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.orangeAccent,
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: MaterialButton(
//                             onPressed: () {
//                               cubit.checkConnecthion();
//                               cubit.result
//                                   ? cubit.getdata(context)
//                                   : SizedBox();
//                             },
//                             child: Text(
//                               'Retry',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Batka',
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }
