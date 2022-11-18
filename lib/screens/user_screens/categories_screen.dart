// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:resturant/models/bloc/cubits/cubit.dart';
// import 'package:resturant/models/bloc/states/states.dart';
// import 'package:resturant/models/dio/dio.dart';
// import 'package:resturant/models/dio/end_points.dart';
// import 'package:resturant/screens/user_screens/categorie_detailes.dart';
// import 'package:resturant/widgets/navigate.dart';

// class CategoriesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<Appcubit, AppState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var cubit = Appcubit.get(context);
//           refresh() {
//             return cubit.getAllCategories();
//           }

//           cubit.checkConnecthion();
//           //      cubit.getGetogries();
//           return cubit.result
//               ? EndPoints.allCategoriesMap.isEmpty
//                   ? RefreshIndicator(
//                       onRefresh: refresh,
//                       child: SingleChildScrollView(
//                         child: Container(
//                           height: MediaQuery.of(context).size.height,
//                           width: MediaQuery.of(context).size.width,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'NO Categories to show',
//                                 style: TextStyle(
//                                   color: EndPoints.isDark
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 18,
//                                   fontFamily: 'Batka',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   : RefreshIndicator(
//                       onRefresh: refresh,
//                       child: GridView.builder(
//                         physics: const BouncingScrollPhysics(
//                             parent: AlwaysScrollableScrollPhysics()),
//                         itemCount: EndPoints.allCategoriesMap.length,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//                               DioFunc.getdate(
//                                 url: EndPoints.getCategoryRecipe +
//                                     EndPoints.allCategoriesMap[index]['name'],
//                               ).then(
//                                 (value) {
//                                   print(value);
//                                   Navigate(
//                                       context: context,
//                                       Screen: CategoriesDetailes(
//                                         Data: value.data,
//                                       ));
//                                 },
//                               );
//                             },
//                             child: Card(
//                               color: EndPoints.isDark
//                                   ? Color(0xff393E46)
//                                   : Colors.white,
//                               margin: EdgeInsets.all(8),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               elevation: 3,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: Center(
//                                   child: Text(
//                                     '${EndPoints.allCategoriesMap[index]['name']}',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontFamily: 'Batka',
//                                         color: EndPoints.isDark
//                                             ? Colors.white
//                                             : EndPoints.isDark
//                                                 ? Colors.white
//                                                 : Colors.black),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 150,
//                         ),
//                       ),
//                     )
//               : Center(
//                   child: Text(
//                     'No internet',
//                     style: TextStyle(
//                         color: EndPoints.isDark
//                             ? Colors.white
//                             : EndPoints.isDark
//                                 ? Colors.white
//                                 : Colors.black),
//                   ),
//                 );
//         });
//   }
// }
