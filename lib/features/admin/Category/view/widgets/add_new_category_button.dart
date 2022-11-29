import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/defaults.dart';
import '../../view_model/bloc/admin_category_bloc.dart';

class AddNewCategoryButton extends StatelessWidget {
  const AddNewCategoryButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var adminCategoryBloc = BlocProvider.of<AdminCategoryBloc>(context);

    return BlocConsumer<AdminCategoryBloc, AdminCategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.categoryAdminAddRequestStatues) {
          case CategoryAdminAddRequestStatues.idle:
            return Defaults.defaultButton(
              context: context,
              title: 'Add Category',
              onPressed: () {
                adminCategoryBloc.add(
                  AddAdminCategoryEvent(
                    adminToken: accessTokenAdminVar,
                    name: TextEditingControllers
                        .categoryAdminAddNameController.text
                        .trim(),
                  ),
                );
              },
            );
          case CategoryAdminAddRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case CategoryAdminAddRequestStatues.success:
            return Defaults.defaultButton(
              context: context,
              title: 'Add Category',
              onPressed: () {
                adminCategoryBloc.add(
                  AddAdminCategoryEvent(
                    adminToken: accessTokenAdminVar,
                    name: TextEditingControllers
                        .categoryAdminAddNameController.text
                        .trim(),
                  ),
                );
              },
            );
          case CategoryAdminAddRequestStatues.error:
            return Defaults.defaultButton(
              context: context,
              title: '',
              onPressed: () {
                adminCategoryBloc.add(
                  AddAdminCategoryEvent(
                    adminToken: accessTokenAdminVar,
                    name: TextEditingControllers
                        .categoryAdminAddNameController.text
                        .trim(),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
