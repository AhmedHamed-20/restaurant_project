import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';

class OrdersAdmin extends StatelessWidget {
  const OrdersAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    String token = CachFunc.getData('token');
    //cubit.getAllOrders(token);
    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Column(
            children: [
              EndPoints.allorders.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: EndPoints.allorders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  showBottomSheet(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25),
                                          topLeft: Radius.circular(25),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: EdgeInsets.all(20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Address',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Batka',
                                                    ),
                                                  ),
                                                  Text(
                                                    EndPoints.allorders[index]
                                                        ['customerAddress'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Phone Number',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Batka',
                                                    ),
                                                  ),
                                                  Text(
                                                    EndPoints.allorders[index]
                                                        ['customerPhoneNumber'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              Center(
                                                child: Text(
                                                  '${EndPoints.allorders[index]['createdAt']}'
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: ListTile(
                                  title: Text(EndPoints.allorders[index]
                                      ['orderContent'][0]['recipeName']),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.orange[200],
                                    radius: 25,
                                    child: Text(
                                      EndPoints.allorders[index]['totalPrice']
                                              .toString() +
                                          ' \$',
                                      style: TextStyle(
                                        color: Colors.orange[900],
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(EndPoints.allorders[index]
                                          ['customerName']),
                                      Text(EndPoints.allorders[index]
                                          ['customerEmail']),
                                    ],
                                  ),
                                  trailing: Text(
                                    EndPoints.allorders[index]['orderContent']
                                                [0]['recipeAmount']
                                            .toString() +
                                        'x ${EndPoints.allorders[index]['orderContent'][0]['recipePrice']}',
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          );
        },
        listener: (context, state) {});
  }
}
