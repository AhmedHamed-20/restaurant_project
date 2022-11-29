import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../view_model/bloc/admin_category_bloc.dart';

class DeleteCategoryAlertDialogWidget extends StatelessWidget {
  const DeleteCategoryAlertDialogWidget({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    var adminCategoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
    return AlertDialog(
      title: Text(
        'Are you sure you want to delete this category?',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        TextButton(
            onPressed: () {
              adminCategoryBloc.add(
                DeleteAdminCategoryEvent(
                  adminToken: accessTokenAdminVar,
                  id: categoryId,
                ),
              );
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'No',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
