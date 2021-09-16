import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/models/bloc/cubits/admin_cubit.dart';
import 'package:resturant/models/bloc/states/admin_state.dart';

class CategoriesAdmin extends StatelessWidget {
  const CategoriesAdmin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Container();
        },
        listener: (context, state) {});
  }
}
