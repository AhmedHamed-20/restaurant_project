// import 'package:flutter/material.dart';
// import 'package:resturant/models/bloc/cubits/cubit.dart';
// import 'package:resturant/models/dio/end_points.dart';

// Widget bottomSheetContent({
//   TextEditingController addressController,
//   TextEditingController PhoneNumberController,
//   BuildContext context,
//   List<Map> orders,
//   String token,
//   String userId,
//   bool isAll,
//   String recipeName,
//   String title,
//   String textfield1Title,
//   String textfield2Title,
//   String buttonTitle,
//   IconData textfield1Icon,
//   IconData textfield2Icon,
//   bool isOrder,
//   Function onpress,
//   bool isEnabled,
// }) {
//   var cubit = Appcubit.get(context);
//   return SingleChildScrollView(
//     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//     child: Container(
//       height: MediaQuery.of(context).size.height,
//       decoration: BoxDecoration(
//         color: EndPoints.isDark ? Color(0xff393E46) : Colors.grey[100],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: EndPoints.isDark
//                   ? Colors.white
//                   : EndPoints.isDark
//                       ? Colors.white
//                       : Colors.black,
//               fontSize: 18,
//               fontFamily: 'Bakta',
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: TextField(
//               enabled: isEnabled,
//               style: TextStyle(
//                 color: EndPoints.isDark
//                     ? Colors.white
//                     : EndPoints.isDark
//                         ? Colors.white
//                         : Colors.black,
//               ),
//               cursorColor: EndPoints.isDark
//                   ? Colors.white
//                   : EndPoints.isDark
//                       ? Colors.white
//                       : Colors.black,
//               controller: addressController,
//               keyboardType: TextInputType.text,
//               onChanged: (value) {},
//               onSubmitted: (val) {},
//               decoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orangeAccent),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide(
//                     color: EndPoints.isDark
//                         ? Colors.white
//                         : EndPoints.isDark
//                             ? Colors.white
//                             : Colors.black,
//                   ),
//                 ),
//                 labelText: textfield1Title,
//                 labelStyle: TextStyle(
//                     color: EndPoints.isDark
//                         ? Colors.white
//                         : EndPoints.isDark
//                             ? Colors.white
//                             : Colors.black),
//                 prefixIcon: Icon(
//                   textfield1Icon,
//                   color: EndPoints.isDark
//                       ? Colors.white
//                       : EndPoints.isDark
//                           ? Colors.white
//                           : Colors.black,
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                   color: EndPoints.isDark
//                       ? Colors.white
//                       : EndPoints.isDark
//                           ? Colors.white
//                           : Colors.black,
//                 )),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: EndPoints.isDark
//                         ? Colors.white
//                         : EndPoints.isDark
//                             ? Colors.white
//                             : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: TextField(
//               style: TextStyle(
//                 color: EndPoints.isDark
//                     ? Colors.white
//                     : EndPoints.isDark
//                         ? Colors.white
//                         : Colors.black,
//               ),
//               cursorColor: EndPoints.isDark
//                   ? Colors.white
//                   : EndPoints.isDark
//                       ? Colors.white
//                       : Colors.black,
//               controller: PhoneNumberController,
//               keyboardType: TextInputType.number,
//               onChanged: (value) {},
//               onSubmitted: (val) {},
//               decoration: InputDecoration(
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.orangeAccent),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide(
//                     color: EndPoints.isDark
//                         ? Colors.white
//                         : EndPoints.isDark
//                             ? Colors.white
//                             : Colors.black,
//                   ),
//                 ),
//                 labelText: textfield2Title,
//                 labelStyle: TextStyle(
//                     color: EndPoints.isDark
//                         ? Colors.white
//                         : EndPoints.isDark
//                             ? Colors.white
//                             : Colors.black),
//                 prefixIcon: Icon(
//                   textfield2Icon,
//                   color: EndPoints.isDark
//                       ? Colors.white
//                       : EndPoints.isDark
//                           ? Colors.white
//                           : Colors.black,
//                 ),
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                   color: EndPoints.isDark
//                       ? Colors.white
//                       : EndPoints.isDark
//                           ? Colors.white
//                           : Colors.black,
//                 )),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: EndPoints.isDark
//                         ? Colors.white
//                         : EndPoints.isDark
//                             ? Colors.white
//                             : Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: 250,
//             height: 50,
//             child: MaterialButton(
//               onPressed: isOrder
//                   ? () {
//                       cubit.createOrder(
//                         orderContent: orders,
//                         address: addressController.text,
//                         phoneNum: PhoneNumberController.text,
//                         token: token,
//                         context: context,
//                         isAll: isAll,
//                         userId: userId,
//                         recipeName: recipeName,
//                       );
//                     }
//                   : onpress,
//               child: Text(
//                 buttonTitle,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontFamily: 'Bakta',
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               color: Colors.lightGreen,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
