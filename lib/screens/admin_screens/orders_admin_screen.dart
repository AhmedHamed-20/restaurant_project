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
    refresh() {
      cubit.page = 2;
      return cubit.getAllOrders(token);
    }

    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return EndPoints.allorders.isEmpty
              ? RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'NO orders to show',
                            style: TextStyle(
                              color: cubit.isDark ? Colors.white : Colors.black,
                              fontSize: 18,
                              fontFamily: 'Batka',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: refresh,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Card(
                      color: cubit.isDark ? Color(0xff393E46) : Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: EndPoints.allorders.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
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
                                              color: cubit.isDark
                                                  ? Color(0xff393E46)
                                                  : Colors.white,
                                              padding: EdgeInsets.all(20),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Address',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Batka',
                                                              color: cubit
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      backgroundColor: cubit
                                                                              .isDark
                                                                          ? Color(
                                                                              0xff393E46)
                                                                          : Colors
                                                                              .white,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        'You sure to delete this order',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color: cubit.isDark
                                                                              ? Colors.white
                                                                              : Colors.black,
                                                                          fontFamily:
                                                                              'Bakta',
                                                                        ),
                                                                      ),
                                                                      content: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            MaterialButton(
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Text(
                                                                                'Cancel',
                                                                                style: TextStyle(
                                                                                  color: cubit.isDark ? Colors.white : Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            MaterialButton(
                                                                              onPressed: () {
                                                                                cubit.cancelOrder(EndPoints.allorders[index]['_id'], token, context);
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Text(
                                                                                'Confirm',
                                                                                style: TextStyle(
                                                                                  color: cubit.isDark ? Colors.white : Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    );
                                                                  });
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors
                                                                  .orangeAccent,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        EndPoints.allorders[
                                                                index]
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
                                                            color: cubit.isDark
                                                                ? Colors.white
                                                                : Colors.grey),
                                                      ),
                                                      Text(
                                                        EndPoints.allorders[
                                                                index][
                                                            'customerPhoneNumber'],
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
                                                        color: cubit.isDark
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            EndPoints.allorders[index]
                                                    ['orderContent'][0]
                                                ['recipeName'],
                                            style: TextStyle(
                                              color: cubit.isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.orange[200],
                                            radius: 25,
                                            child: Text(
                                              EndPoints.allorders[index]
                                                          ['totalPrice']
                                                      .toString() +
                                                  ' \$',
                                              style: TextStyle(
                                                color: Colors.orange[900],
                                              ),
                                            ),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                EndPoints.allorders[index]
                                                    ['customerName'],
                                                style: TextStyle(
                                                  color: cubit.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                              Text(
                                                EndPoints.allorders[index]
                                                    ['customerEmail'],
                                                style: TextStyle(
                                                  color: cubit.isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            EndPoints.allorders[index]
                                                        ['orderContent'][0]
                                                        ['recipeAmount']
                                                    .toString() +
                                                'x ${EndPoints.allorders[index]['orderContent'][0]['recipePrice']}',
                                            style: TextStyle(
                                              color: cubit.isDark
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  color: cubit.isDark
                                      ? Color(0xff222831)
                                      : Colors.grey[300],
                                  thickness: 1.5,
                                );
                              },
                            ),
                          ),
                          (cubit.noData || EndPoints.allorders.length < 10)
                              ? SizedBox()
                              : state is PageLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      color: Colors.orangeAccent,
                                      onPressed: () {
                                        cubit.pageinathionOrders(token);
                                      },
                                      child: Text(
                                        'load more',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                        ],
                      ),
                    ),
                  ),
                );
        },
        listener: (context, state) {});
  }
}
