import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/cubit.dart';
import 'package:resturant/models/bloc/states/states.dart';
import 'package:resturant/models/dio/end_points.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Appcubit.get(context);
          //      cubit.getGetogries();
          return EndPoints.allCategoriesMap == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: EndPoints.allCategoriesMap['results'],
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          '${EndPoints.allCategoriesMap['data']['data'][index]['name']}'),
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
