import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/layout/user/view/widgets/update_alert_dialog_widget.dart';
import 'package:resturant/core/widget/defaults.dart';

import '../../../../const/const.dart';
import '../../../../utls/utls.dart';
import '../../view_model/bloc/layout_bloc.dart';

class UpdateButtonWidget extends StatelessWidget {
  const UpdateButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutBloc, LayoutState>(
      listener: (context, state) {
        if (state.activeUserUpdateDataRequestStatues ==
            ActiveUserUpdateDataRequestStatues.success) {
          flutterToast(
              msg: 'Updated Sucess',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
        }
        if (state.activeUserUpdateDataRequestStatues ==
            ActiveUserUpdateDataRequestStatues.error) {
          flutterToast(
            msg: state.errorMessage,
            backgroundColor: AppColors.toastError,
            textColor: AppColors.white,
          );
        }
      },
      builder: (context, state) {
        switch (state.activeUserUpdateDataRequestStatues) {
          case ActiveUserUpdateDataRequestStatues.idle:
            return Defaults.defaultButton(
                context: context,
                title: 'Update',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const UpdateAlertDialogWidget();
                      });
                });
          case ActiveUserUpdateDataRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case ActiveUserUpdateDataRequestStatues.success:
            return Defaults.defaultButton(
                context: context,
                title: 'Update',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const UpdateAlertDialogWidget();
                      });
                });

          case ActiveUserUpdateDataRequestStatues.error:
            return Defaults.defaultButton(
                context: context,
                title: 'Update',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const UpdateAlertDialogWidget();
                      });
                });
        }
      },
    );
  }
}
