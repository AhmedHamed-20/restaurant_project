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
            : cubit.OrdersMap['data'].isEmpty
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
                                color: Color(0xfff8f8f8),
                                elevation: 1,
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
                                                Text(
                                                  '${cubit.OrdersMap['data'][index1]['orderContent'][index]['recipeName']}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Batka',
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Text(
                                                  'amount: ${cubit.OrdersMap['data'][index1]['orderContent'][index]['recipeAmount'].toString()}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      Row(
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
                                            ' ${cubit.OrdersMap['data'][index1]['createdAt'].toString()}',
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
