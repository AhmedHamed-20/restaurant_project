// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:resturant/models/bloc/cubits/cubit.dart';
// import 'package:resturant/models/bloc/states/states.dart';
// import 'package:resturant/models/databasae/database.dart';
// import 'package:resturant/models/dio/end_points.dart';
// import 'package:resturant/screens/user_screens/detailes_screen.dart';
// import 'package:resturant/widgets/all_fodods.dart';
// import 'package:resturant/widgets/navigate.dart';
// import 'package:resturant/widgets/search.dart';

// class SearchScrean extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var cubit = Appcubit.get(context);
//     return BlocConsumer<Appcubit, AppState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: EndPoints.isDark ? Color(0xff222831) : Colors.white,
//           appBar: AppBar(
//             leading: MaterialButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 color: EndPoints.isDark
//                     ? Colors.white
//                     : EndPoints.isDark
//                         ? Colors.white
//                         : Colors.black,
//               ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             title: Text(
//               'Search',
//               style: TextStyle(
//                 color: EndPoints.isDark ? Colors.white : Colors.grey[800],
//                 fontFamily: 'Batka',
//               ),
//             ),
//             iconTheme: IconThemeData(
//               color: Colors.grey[800],
//             ),
//             centerTitle: true,
//           ),
//           body: Column(
//             children: [
//               search(context),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.2,
//               ),
//               cubit.searchMap == null
//                   ? Center(
//                       child: Text(
//                         'Search Now',
//                         style: TextStyle(
//                           color: EndPoints.isDark
//                               ? Colors.white
//                               : EndPoints.isDark
//                                   ? Colors.white
//                                   : Colors.black,
//                           fontSize: 18,
//                           fontFamily: 'Batka',
//                         ),
//                       ),
//                     )
//                   : Expanded(
//                       child: ListView.builder(
//                           itemCount: cubit.searchMap['data']['data'].length,
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () {
//                                 Navigate(
//                                   context: context,
//                                   Screen: DetailesScreen(
//                                     name: cubit.searchMap['data']['data'][index]
//                                         ['name'],
//                                     descripthion: cubit.searchMap['data']
//                                         ['data'][index]['slug'],
//                                     imageurl: cubit.searchMap['data']['data']
//                                         [index]['imageCover'],
//                                     price: cubit.searchMap['data']['data']
//                                         [index]['price'],
//                                     index: index,
//                                     Ingridients: cubit.searchMap['data']['data']
//                                         [index]['ingredients'],
//                                     email: DataBaseFun.storedData[0]['email'],
//                                     userId: DataBaseFun.storedData[0]['userId'],
//                                     recipeId: EndPoints.allRecipiesMap['data']
//                                         ['data'][index]['_id'],
//                                   ),
//                                 );
//                               },
//                               child: allFoods(
//                                   context: context,
//                                   name: cubit.searchMap['data']['data'][index]
//                                       ['name'],
//                                   description: cubit.searchMap['data']['data']
//                                       [index]['slug'],
//                                   imageurl: cubit.searchMap['data']['data']
//                                       [index]['imageCover'],
//                                   index: index,
//                                   price: cubit.searchMap['data']['data'][index]
//                                           ['price']
//                                       .toString(),
//                                   Ingredients: cubit.searchMap['data']['data']
//                                       [index]['ingredients'],
//                                   cookingTime: cubit.searchMap['data']['data']
//                                           [index]['cookingTime']
//                                       .toString(),
//                                   state: state),
//                             );
//                           }),
//                     )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
