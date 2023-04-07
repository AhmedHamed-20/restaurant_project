import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/services/service_locator.dart';
import 'package:resturant/features/admin/AllUsers/view_model/bloc/allusers_bloc.dart';

import '../../../../../core/utls/utls.dart';
import '../widgets/all_users_admin_main_widget.dart';

class AllUsersAdminScrenn extends StatelessWidget {
  const AllUsersAdminScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AllUsersBloc>()
        ..add(AllUsersGetEvent(adminToken: accessTokenAdminVar, page: 1)),
      child: BlocBuilder<AllUsersBloc, AllUsersState>(
        builder: (context, state) {
          switch (state.allUsersRequestStatues) {
            case AllUsersRequestStatues.loading:
              return const Center(child: CircularProgressIndicator());
            case AllUsersRequestStatues.success:
              return const AllUsersAdminMainWidget();
            case AllUsersRequestStatues.error:
              return Center(
                child: Text(state.errorMessage),
              );
          }
        },
      ),
    );
  }
}
