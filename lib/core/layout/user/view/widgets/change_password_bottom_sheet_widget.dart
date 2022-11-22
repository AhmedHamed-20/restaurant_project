import 'package:flutter/material.dart';

import '../../../../const/const.dart';
import '../../../../const/text_editing_controllers.dart';
import '../../../../widget/defaults.dart';

class ChangePasswordBottomSheetWidget extends StatelessWidget {
  const ChangePasswordBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.p20,
        right: AppPadding.p20,
        top: AppPadding.p20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: screenHeight(context) * 0.6,
        child: Column(
          children: [
            Text(
              'Change Password',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            Defaults.defaultTextField(
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              controller:
                  TextEditingControllers.activeUserDataOldPasswordController,
              title: 'Old Password',
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            Defaults.defaultTextField(
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              controller:
                  TextEditingControllers.activeUserDataPasswordController,
              title: 'New Password',
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            Defaults.defaultTextField(
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              controller:
                  TextEditingControllers.activeUserDataPasswordController,
              title: 'Confirm Password',
            ),
            const SizedBox(
              height: AppHeight.h20,
            ),
            Defaults.defaultButton(
              context: context,
              title: 'Change Password',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
