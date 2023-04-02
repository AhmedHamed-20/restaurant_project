import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';

class UserDeleteAlertDialogWidget extends StatelessWidget {
  const UserDeleteAlertDialogWidget({
    required this.userId,
    Key? key,
  }) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    var allUsersAdminBloc = BlocProvider.of<AllUsersBloc>(context);
    return BlocConsumer<AllUsersBloc, AllUsersState>(
      listener: (context, state) {
        if (state.deleteUserByIdRequestStatues ==
            AllUsersRequestStatues.success) {
          flutterToast(
              msg: 'User Deleted Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.pop(context);
        }
        if (state.deleteUserByIdRequestStatues ==
            AllUsersRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r25),
          ),
          title: Text(
            'Delete User',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to delete this user?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            TextButton(
              onPressed: () {
                allUsersAdminBloc.add(
                  UserDeleteEvent(
                    adminToken: accessTokenAdminVar,
                    userId: userId,
                  ),
                );
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
