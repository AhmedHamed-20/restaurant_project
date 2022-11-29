import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';

import '../../view_model/bloc/admin_category_bloc.dart';
import 'add_new_category_bottom_sheet_widget.dart';
import 'category_update_model_bottom_sheet_widget.dart';
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
          itemCount: state.categoryModel!.categoryData.length + 1,
          itemBuilder: (context, index) {
            if (index < state.categoryModel!.categoryData.length) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Theme.of(context).backgroundColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppRadius.r20),
                          topRight: Radius.circular(AppRadius.r20),
                        ),
                      ),
                      builder: (context) {
                        return BlocProvider.value(
                          value: adminCategoryBloc,
                          child: CategoryUpdateModelBottomSheetWidget(
                            categoryDataModel:
                                state.categoryModel!.categoryData[index],
                          ),
                        );
                      });
                },
                child: ListTile(
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
                                  categoryId: state
                                      .categoryModel!.categoryData[index].id),
                            );
                          });
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                        context: context,
                        builder: (context) {
                          return BlocProvider.value(
                            value: adminCategoryBloc,
                            child: const AddNewCategoryBottomSheetWidget(),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
