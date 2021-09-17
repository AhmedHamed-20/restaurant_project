import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';
import 'package:resturant/models/cach/chach.dart';

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
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: cubit.allorders.length,
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
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
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
                                              cubit.allorders[index]
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
                                              cubit.allorders[index]
                                                  ['customerPhoneNumber'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            '${cubit.allorders[index]['createdAt']}'
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
                            title: Text(cubit.allorders[index]['orderContent']
                                [0]['recipeName']),
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange[200],
                              radius: 25,
                              child: Text(
                                cubit.allorders[index]['totalPrice']
                                        .toString() +
                                    ' \$',
                                style: TextStyle(
                                  color: Colors.orange[900],
                                ),
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cubit.allorders[index]['customerName']),
                                Text(cubit.allorders[index]['customerEmail']),
                              ],
                            ),
                            trailing: Text(
                              cubit.allorders[index]['orderContent'][0]
                                          ['recipeAmount']
                                      .toString() +
                                  'x ${cubit.allorders[index]['orderContent'][0]['recipePrice']}',
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
