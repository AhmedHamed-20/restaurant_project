import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/app_routes_names.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/layout/user/view_model/bloc/layout_bloc.dart';
import 'package:resturant/core/utls/utls.dart';

class LogoutAlertDialogWidget extends StatelessWidget {
  const LogoutAlertDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return AlertDialog(
      title: Text(
        'Are you sure you want to logout?',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        BlocConsumer<LayoutBloc, LayoutState>(
          listener: (context, state) {
            if (state.logoutRequestState ==
                LogoutRequestState.databaseCleared) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutesNames.loginScreen, (route) => false);
            }
            if (state.logoutRequestState == LogoutRequestState.error) {
              Navigator.pop(context);
              flutterToast(
                  msg: state.errorMessage == '' ? 'error' : state.errorMessage,
                  backgroundColor: AppColors.toastError,
                  textColor: AppColors.white);
            }
          },
          builder: (context, state) {
            return TextButton(
                onPressed: () {
                  layoutBloc.add(
                    CacheClearAndDatabseClearEvent(
                      key: 'accessToken',
                      userId: state.activeUser!.id,
                      tableName: 'favorite',
                    ),
                  );
                },
                child: Text('Yes',
                    style: Theme.of(context).textTheme.titleMedium));
          },
        ),
      ],
    );
  }
}
