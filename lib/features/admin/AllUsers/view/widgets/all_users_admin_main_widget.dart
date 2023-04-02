import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';

import 'all_users_admin_alert_dialog_delete_widget.dart';
import 'all_users_admin_model_bottom_sheet_widget.dart';

int allUsersPage = 2;

class AllUsersAdminMainWidget extends StatefulWidget {
  const AllUsersAdminMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AllUsersAdminMainWidget> createState() =>
      _AllUsersAdminMainWidgetState();
}

class _AllUsersAdminMainWidgetState extends State<AllUsersAdminMainWidget> {
  final ScrollController scrollController = ScrollController();
  bool isEndOfData = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfData == false) {
        BlocProvider.of<AllUsersBloc>(context).add(
          MoreUsersGetEvent(
            adminToken: accessTokenAdminVar,
            page: allUsersPage.toString(),
          ),
        );
        allUsersPage++;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    isEndOfData = false;
    allUsersPage = 2;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allUserBloc = BlocProvider.of<AllUsersBloc>(context);
    return BlocConsumer<AllUsersBloc, AllUsersState>(
      listener: (context, state) {
        isEndOfData = state.isEndOfData;
      },
      builder: (context, state) {
        return ListView.builder(
          controller: scrollController,
          itemCount: state.allUsersModel!.usersData.length + 1,
          itemBuilder: (context, index) {
            if (index < state.allUsersModel!.usersData.length) {
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
                    backgroundColor: Theme.of(context).colorScheme.background,
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
                                userId:
                                    state.allUsersModel!.usersData[index].id,
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
            } else {
              return state.isEndOfData
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.all(AppPadding.p10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }
          },
        );
      },
    );
  }
}
