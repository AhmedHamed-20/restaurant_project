import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/cach/chach.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/all_fodods.dart';
import 'package:resturant/widgets/custome_dialog.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        String token = CachFunc.getData('token');
        TextEditingController addressController = TextEditingController();
        TextEditingController PhoneNumberController = TextEditingController();
        var cubit = Appcubit.get(context);
        return EndPoints.FilteredCartDataBase.isEmpty
            ? Center(
                child: Text(
                  'Shop and add your best foods to cart now',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: EndPoints.FilteredCartDataBase.length,
                itemBuilder: (context, index) {
                  return allFoods(
                    context: context,
                    index: index,
                    name: EndPoints.FilteredCartDataBase[index]['recipeName'],
                    price: EndPoints.FilteredCartDataBase[index]['price']
                        .toString(),
                    imageurl: EndPoints.FilteredCartDataBase[index]['photourl'],
                    description: EndPoints.FilteredCartDataBase[index]['slug'],
                    button: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff7b9c72),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: MaterialButton(
                        elevation: 3,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => customeDialog(
                              addressController,
                              PhoneNumberController,
                              context,
                              EndPoints.FilteredCartDataBase[index]['recipeId'],
                              token,
                              EndPoints.FilteredCartDataBase[index]['amount'],
                              EndPoints.FilteredCartDataBase[index]
                                  ['recipeName'],
                              EndPoints.FilteredCartDataBase[index]['userId'],
                            ),
                          );
                        },
                        child: Text(
                          'Order Now',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                });
      },
    );
  }
}
