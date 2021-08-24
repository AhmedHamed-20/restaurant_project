import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Appcubit.get(context);
          cubit.getGetogries();
          return ListView.separated(
            itemCount: cubit.allCategories['results'],
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    '${cubit.allCategories['data']['data'][index]['name']}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.grey,
              );
            },
          );
        });
  }
}
