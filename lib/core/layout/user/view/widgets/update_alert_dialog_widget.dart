import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/layout/user/view_model/bloc/layout_bloc.dart';

import '../../../../const/text_editing_controllers.dart';

class UpdateAlertDialogWidget extends StatelessWidget {
  const UpdateAlertDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return AlertDialog(
      title: Text(
        'Are you sure',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(
        'Do you want to update your data?',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        TextButton(
          onPressed: () {
            layoutBloc.add(
              ActiveUserDataUpdateEvent(
                accessToken: accessTokenVar,
                name: TextEditingControllers.activeUserDataNameController.text
                    .trim(),
                email: TextEditingControllers.activeUserDataEmailController.text
                    .trim(),
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text('Yes', style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}
