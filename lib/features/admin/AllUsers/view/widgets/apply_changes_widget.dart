import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllUsers/view/widgets/all_users_admin_model_bottom_sheet_widget.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';

import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/defaults.dart';
import 'apply_changes_button_design.dart';

class ApplyChangesButtonWidget extends StatelessWidget {
  const ApplyChangesButtonWidget({
    super.key,
    required this.role,
    required this.userId,
  });

  final String role;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllUsersBloc, AllUsersState>(
      listener: (context, state) {
        if (state.updateUserDataByIdRequestStatues ==
            AllUsersUpdateDataRequestStatues.success) {
          flutterToast(
              msg: 'User Data Updated Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.pop(context);
        }

        if (state.updateUserDataByIdRequestStatues ==
            AllUsersUpdateDataRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        switch (state.updateUserDataByIdRequestStatues) {
          case AllUsersUpdateDataRequestStatues.idle:
            return ApplyChangesButtonDesign(
              role: role,
              userId: userId,
            );
          case AllUsersUpdateDataRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case AllUsersUpdateDataRequestStatues.success:
            return ApplyChangesButtonDesign(
              role: role,
              userId: userId,
            );
          case AllUsersUpdateDataRequestStatues.error:
            return ApplyChangesButtonDesign(
              role: role,
              userId: userId,
            );
        }
      },
    );
  }
}
