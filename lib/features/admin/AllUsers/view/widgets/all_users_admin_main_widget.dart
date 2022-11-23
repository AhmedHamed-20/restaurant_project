import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';

import 'all_users_admin_alert_dialog_delete_widget.dart';
import 'all_users_admin_model_bottom_sheet_widget.dart';

class AllUsersAdminMainWidget extends StatelessWidget {
  const AllUsersAdminMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allUserBloc = BlocProvider.of<AllUsersBloc>(context);
    return BlocBuilder<AllUsersBloc, AllUsersState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.allUsersModel!.usersData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppRadius.r25),
                    ),
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: allUserBloc,
                      child: AllUsersModelBottomSheetWidget(
                        email: state.allUsersModel!.usersData[index].email,
                        name: state.allUsersModel!.usersData[index].name,
                        role: state.allUsersModel!.usersData[index].role,
                        userId: state.allUsersModel!.usersData[index].id,
                      ),
                    );
                  },
                );
              },
              child: ListTile(
                title: Text(
                  state.allUsersModel!.usersData[index].name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  state.allUsersModel!.usersData[index].role,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider.value(
                            value: allUserBloc,
                            child: UserDeleteAlertDialogWidget(
                              userId: state.allUsersModel!.usersData[index].id,
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
