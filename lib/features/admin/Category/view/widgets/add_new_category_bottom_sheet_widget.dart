import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../../../../core/utls/utls.dart';
import '../../../../../core/widget/defaults.dart';
import '../../view_model/bloc/admin_category_bloc.dart';
import 'add_new_category_button.dart';

class AddNewCategoryBottomSheetWidget extends StatelessWidget {
  const AddNewCategoryBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var adminCategoryBloc = BlocProvider.of<AdminCategoryBloc>(context);

    return BlocListener<AdminCategoryBloc, AdminCategoryState>(
      listener: (context, state) {
        if (state.categoryAdminAddRequestStatues ==
            CategoryAdminAddRequestStatues.success) {
          flutterToast(
              msg: 'Added Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          Navigator.of(context).pop();
        } else if (state.categoryAdminAddRequestStatues ==
            CategoryAdminAddRequestStatues.error) {
          flutterToast(
              msg: state.errorMessage,
              backgroundColor: AppColors.toastError,
              textColor: AppColors.white);
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: AppPadding.p10,
            right: AppPadding.p10,
            top: AppPadding.p10,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: screenHeight(context) * 0.4,
          child: Column(
            children: [
              Text(
                'Add New Category',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              Defaults.defaultTextField(
                prefixIcon: Icon(
                  Icons.text_fields,
                  color: Theme.of(context).iconTheme.color,
                ),
                context: context,
                controller:
                    TextEditingControllers.categoryAdminAddNameController,
                title: 'Name',
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              BlocProvider.value(
                value: adminCategoryBloc,
                child: const AddNewCategoryButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
