import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/widget/defaults.dart';
import 'package:resturant/features/admin/Category/view_model/bloc/admin_category_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../models/admin_category_model_data.dart';
import 'apply_changes_button.dart';

class CategoryUpdateModelBottomSheetWidget extends StatefulWidget {
  const CategoryUpdateModelBottomSheetWidget({
    Key? key,
    required this.categoryDataModel,
  }) : super(key: key);
  final AdminCategoryDataModel categoryDataModel;

  @override
  State<CategoryUpdateModelBottomSheetWidget> createState() =>
      _CategoryUpdateModelBottomSheetWidgetState();
}

class _CategoryUpdateModelBottomSheetWidgetState
    extends State<CategoryUpdateModelBottomSheetWidget> {
  @override
  void initState() {
    super.initState();
    TextEditingControllers.categoryAdminNameController.text =
        widget.categoryDataModel.name;
  }

  @override
  Widget build(BuildContext context) {
    var adminCategoryBloc = BlocProvider.of<AdminCategoryBloc>(context);

    return Padding(
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
              'Edit Category Name',
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
              controller: TextEditingControllers.categoryAdminNameController,
              title: 'Name',
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            BlocProvider.value(
              value: adminCategoryBloc,
              child: ApplyChangesButton(
                categoryId: widget.categoryDataModel.id,
              ),
            )
          ],
        ),
      ),
    );
  }
}
