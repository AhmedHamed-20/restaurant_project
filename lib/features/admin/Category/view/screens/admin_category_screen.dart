import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/services/service_locator.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/admin_category_bloc.dart';
import '../widgets/main_admin_category_widget.dart';

class AdminCategoryScreen extends StatelessWidget {
  const AdminCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AdminCategoryBloc>()
        ..add(const GetAdminCategoriesEvent()),
      child: BlocBuilder<AdminCategoryBloc, AdminCategoryState>(
        builder: (context, state) {
          switch (state.categoryAdminRequestStatues) {
            case CategoryAdminRequestStatues.loading:
              return const Center(child: CircularProgressIndicator());
            case CategoryAdminRequestStatues.success:
              return const MainAdminCategoryWidget();
            case CategoryAdminRequestStatues.error:
              return Center(child: Text(state.errorMessage));
          }
        },
      ),
    );
  }
}
