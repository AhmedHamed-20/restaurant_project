import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    String token = CachFunc.getData('token');
    final f = DateFormat('yyyy-MM-dd hh:mm');
    cubit.getmyOrders(token);
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is LoadingState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (cubit.OrdersMap.isEmpty || cubit.OrdersMap['data'].isEmpty)
                ? Center(
                    child: Text(
                      'order your recipes now',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: cubit.OrdersMap['data'].length,
                            itemBuilder: (context, index1) {
                              return Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.grey[50],
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  // height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: cubit
                                              .OrdersMap['data'][index1]
                                                  ['orderContent']
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Text(
                                                        '${cubit.OrdersMap['data'][index1]['orderContent'][index]['recipeName']}',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: 'Batka',
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'amount: ${cubit.OrdersMap['data'][index1]['orderContent'][index]['recipeAmount'].toString()}x ${cubit.OrdersMap['data'][index1]['orderContent'][index]['recipePrice'].toString()}=${cubit.OrdersMap['data'][index1]['orderContent'][index]['recipePrice'] * cubit.OrdersMap['data'][index1]['orderContent'][index]['recipeAmount']}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: MaterialButton(
                                          onPressed: () {
                                            print(cubit.OrdersMap['data']
                                                [index1]['_id']);
                                            print(token);
                                            cubit.cancelOrder(
                                              cubit.OrdersMap['data'][index1]
                                                  ['_id'],
                                              token,
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          color: Colors.orangeAccent,
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'TotalPrice: ${cubit.OrdersMap['data'][index1]['totalPrice'].toString()}\$',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Batka',
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text(
                                            ' ${cubit.OrdersMap['data'][index1]['createdAt'].toString()}'
                                                .substring(1, 11),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Batka',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
      },
    );
  }
}
