import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/admin/Category/view_model/bloc/admin_category_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/defaults.dart';

class ApplyChangesButton extends StatelessWidget {
  const ApplyChangesButton({super.key, required this.categoryId});
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    var adminCategoryBloc = BlocProvider.of<AdminCategoryBloc>(context);

    return BlocConsumer<AdminCategoryBloc, AdminCategoryState>(
      listener: (context, state) {
        if (state.categoryAdminUpdateRequestStatues ==
            CategoryAdminUpdateRequestStatues.success) {
          flutterToast(
              msg: 'Updated Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.of(context).pop();
        } else if (state.categoryAdminUpdateRequestStatues ==
            CategoryAdminUpdateRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        switch (state.categoryAdminUpdateRequestStatues) {
          case CategoryAdminUpdateRequestStatues.idle:
            return Defaults.defaultButton(
              context: context,
              title: 'Apply Changes',
              onPressed: () {
                adminCategoryBloc.add(
                  UpdateAdminCategoryEvent(
                      adminToken: accessTokenAdminVar,
                      name: TextEditingControllers
                          .categoryAdminNameController.text
                          .trim(),
                      id: categoryId),
                );
              },
            );
          case CategoryAdminUpdateRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case CategoryAdminUpdateRequestStatues.success:
            return Defaults.defaultButton(
              context: context,
              title: 'Apply Changes',
              onPressed: () {
                adminCategoryBloc.add(
                  UpdateAdminCategoryEvent(
                      adminToken: accessTokenAdminVar,
                      name: TextEditingControllers
                          .categoryAdminNameController.text
                          .trim(),
                      id: categoryId),
                );
              },
            );
          case CategoryAdminUpdateRequestStatues.error:
            return Defaults.defaultButton(
              context: context,
              title: 'Apply Changes',
              onPressed: () {
                adminCategoryBloc.add(
                  UpdateAdminCategoryEvent(
                      adminToken: accessTokenAdminVar,
                      name: TextEditingControllers
                          .categoryAdminNameController.text
                          .trim(),
                      id: categoryId),
                );
              },
            );
        }
      },
    );
  }
}
