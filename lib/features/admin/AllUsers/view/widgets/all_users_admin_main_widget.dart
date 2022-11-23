import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';

class AllUsersAdminMainWidget extends StatelessWidget {
  const AllUsersAdminMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      return SizedBox(
                        height: screenHeight(context) * 0.6,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: AppPadding.p10,
                            right: AppPadding.p10,
                            top: AppPadding.p10,
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'User Information',
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: ListTile(
                title: Text(
                  state.allUsersModel!.usersData[index].name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(
                  state.allUsersModel!.usersData[index].email,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  onPressed: () {},
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
