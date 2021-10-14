import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/databasae/cart_database.dart';
import 'package:resturant/models/databasae/database.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/bottomSheetContent.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    cubit.ispressed = false;
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        String token = CachFunc.getData('token');

        TextEditingController addressController = TextEditingController();
        TextEditingController PhoneNumberController = TextEditingController();
        TextEditingController RecipeName = TextEditingController();
        TextEditingController amount = TextEditingController();

        return EndPoints.FilteredCartDataBase.isEmpty
            ? Center(
                child: Text(
                  'Shop and add your best foods to cart now',
                  style: TextStyle(
                    color: EndPoints.isDark
                        ? Colors.white
                        : EndPoints.isDark
                            ? Colors.white
                            : Colors.black,
                    fontSize: 18,
                  ),
                ),
              )
            : Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: Container(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: MaterialButton(
                    elevation: 5,
                    child: Text(
                      'Add All',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Batka',
                      ),
                    ),
                    onPressed: () {
                      List<Map> orders = [];
                      for (int i = 0;
                          i < EndPoints.FilteredCartDataBase.length;
                          i++) {
                        if (DataBaseFun.storedData[0]['userId'] ==
                            EndPoints.FilteredCartDataBase[i]['userId'])
                          orders.add({
                            'recipeId':
                                '${EndPoints.FilteredCartDataBase[i]['recipeId']}',
                            'amount': EndPoints.FilteredCartDataBase[i]
                                ['amount'],
                          });
                      }
                      print(orders);
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            ),
                          ),
                          context: context,
                          builder: (_) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: bottomSheetContent(
                                isEnabled: true,
                                isOrder: true,
                                title: 'We need this data (:',
                                buttonTitle: 'Order Now',
                                textfield1Icon: Icons.add_location,
                                textfield2Icon: Icons.phone,
                                textfield1Title: 'Address',
                                textfield2Title: 'Phone Number',
                                isAll: true,
                                addressController: addressController,
                                PhoneNumberController: PhoneNumberController,
                                token: token,
                                context: context,
                                orders: orders,
                                userId: DataBaseFun.storedData[0]['userId'],
                              ),
                            );
                          });
                    },
                  ),
                ),
                backgroundColor:
                    EndPoints.isDark ? Color(0xff222831) : Colors.white,
                body: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: EndPoints.FilteredCartDataBase.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direc) {
                          CartDataBaseFun.deleteFromDataBaseNameandId(
                                  EndPoints.FilteredCartDataBase[index]
                                      ['recipeName'],
                                  context,
                                  DataBaseFun.storedData[0]['userId'])
                              .then((value) {
                            cubit.chagestate();
                            Fluttertoast.showToast(
                              msg: 'Deleted Success',
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                          });
                        },
                        background: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.orangeAccent,
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: EndPoints.isDark
                                    ? Color(0xff393E46)
                                    : Colors.grey[100],
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  RecipeName.text =
                                      EndPoints.FilteredCartDataBase[index]
                                          ['recipeName'];
                                  amount.text = EndPoints
                                      .FilteredCartDataBase[index]['amount']
                                      .toString();
                                  return bottomSheetContent(
                                      isEnabled: false,
                                      isOrder: false,
                                      title: 'Recipe information (:',
                                      buttonTitle: 'Update',
                                      textfield1Icon: Icons.text_fields,
                                      textfield2Icon: Icons.add_road_outlined,
                                      textfield1Title: 'Recipe Name',
                                      isAll: false,
                                      textfield2Title: 'Amount',
                                      context: context,
                                      addressController: RecipeName,
                                      PhoneNumberController: amount,
                                      onpress: () {
                                        cubit.updateCardDataBase(
                                            recipeName: EndPoints
                                                    .FilteredCartDataBase[index]
                                                ['recipeName'],
                                            amount: int.parse(amount.text),
                                            id: DataBaseFun.storedData[0]
                                                ['userId'],
                                            context: context);
                                      });
                                });
                            print(RecipeName.text);
                            print(amount.text);
                          },
                          child: allFoods(
                            context: context,
                            index: index,
                            name: EndPoints.FilteredCartDataBase[index]
                                ['recipeName'],
                            price:
                                '${EndPoints.FilteredCartDataBase[index]['price'] * EndPoints.FilteredCartDataBase[index]['amount']}',
                            imageurl: EndPoints.FilteredCartDataBase[index]
                                ['photourl'],
                            description: EndPoints.FilteredCartDataBase[index]
                                ['slug'],
                            button: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff7b9c72),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: MaterialButton(
                                    elevation: 3,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: EndPoints.isDark
                                              ? Color(0xff393E46)
                                              : Colors.grey[100],
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (_) {
                                            return bottomSheetContent(
                                              isEnabled: true,
                                              isOrder: true,
                                              title: 'We need this data (:',
                                              buttonTitle: 'Order Now',
                                              textfield1Icon:
                                                  Icons.add_location,
                                              textfield2Icon: Icons.phone,
                                              textfield1Title: 'Address',
                                              textfield2Title: 'Phone Number',
                                              recipeName: EndPoints
                                                      .FilteredCartDataBase[
                                                  index]['recipeName'],
                                              isAll: false,
                                              context: context,
                                              userId: DataBaseFun.storedData[0]
                                                  ['userId'],
                                              token: token,
                                              addressController:
                                                  addressController,
                                              PhoneNumberController:
                                                  PhoneNumberController,
                                              orders: [
                                                {
                                                  'recipeId':
                                                      '${EndPoints.FilteredCartDataBase[index]['recipeId']}',
                                                  'amount': EndPoints
                                                          .FilteredCartDataBase[
                                                      index]['amount'],
                                                },
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Order Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
      },
    );
  }
}
