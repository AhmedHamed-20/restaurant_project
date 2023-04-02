import 'package:flutter/material.dart';

import '../../../../const/const.dart';
import '../../../../widget/defaults.dart';
import 'change_password_bottom_sheet_widget.dart';

class UpdatePasswordButtonWidget extends StatelessWidget {
  const UpdatePasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Defaults.defaultButton(
      context: context,
      title: 'Change Password',
      onPressed: () {
        showModalBottomSheet(
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.r20),
                topRight: Radius.circular(AppRadius.r20),
              ),
            ),
            context: context,
            builder: (context) {
              return const ChangePasswordBottomSheetWidget();
            });
      },
    );
  }
}
