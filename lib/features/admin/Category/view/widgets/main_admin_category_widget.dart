import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';

import '../../view_model/bloc/admin_category_bloc.dart';
import 'delete_category_alert_dialog_widget.dart';

class MainAdminCategoryWidget extends StatelessWidget {
  const MainAdminCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var adminCategoryBloc = BlocProvider.of<AdminCategoryBloc>(context);
    return BlocBuilder<AdminCategoryBloc, AdminCategoryState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.categoryModel!.categoryData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                state.categoryModel!.categoryData[index].name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: adminCategoryBloc,
                          child: DeleteCategoryAlertDialogWidget(
                              categoryId:
                                  state.categoryModel!.categoryData[index].id),
                        );
                      });
                },
              ),
            );
          },
        );
      },
    );
  }
}
