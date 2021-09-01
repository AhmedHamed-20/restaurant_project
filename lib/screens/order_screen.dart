import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = Appcubit.get(context);
    String token = CachFunc.getData('token');
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
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Color(0xfff8f8f8),
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cubit.OrdersMap['data'][index]
                                                        ['orderContent'][0]
                                                    ['recipeName'],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Batka',
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                cubit.OrdersMap['data'][index]
                                                        ['orderContent'][0]
                                                        ['recipeAmount']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                '\$ ${cubit.OrdersMap['data'][index]['orderContent'][0]['recipePrice'].toString()}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Batka',
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
