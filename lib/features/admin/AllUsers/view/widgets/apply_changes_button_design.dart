import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/widget/defaults.dart';
import '../../view_model/bloc/allusers_bloc.dart';
import 'all_users_admin_model_bottom_sheet_widget.dart';

class ApplyChangesButtonDesign extends StatelessWidget {
  const ApplyChangesButtonDesign(
      {super.key, required this.role, required this.userId});
  final String role;
  final String userId;
  @override
  Widget build(BuildContext context) {
    var allUsersBloc = BlocProvider.of<AllUsersBloc>(context);

    return Defaults.defaultButton(
        context: context,
        title: 'Apply Changes',
        onPressed: () {
          allUsersBloc.add(UserDataUpdateByIdEvent(
              adminToken: accessTokenAdminVar,
              userId: userId,
              name: TextEditingControllers.allUsersNameController.text.trim(),
              email: TextEditingControllers.allUsersEmailController.text.trim(),
              role: roleNewValue == '' ? role : roleNewValue));
        });
  }
}
