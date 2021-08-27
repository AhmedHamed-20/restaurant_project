import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/dio/end_points.dart';
import 'package:resturant/widgets/all_fodods.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Appcubit.get(context);
        return EndPoints.FilteredCartDataBase == null
            ? Center(
                child: Text(
                  'Shop and add your best food to cart now',
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
                  );
                });
      },
    );
  }
}
