import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/widget/defaults.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/const/text_editing_controllers.dart';
import '../../view_model/bloc/allusers_bloc.dart';
import 'apply_changes_widget.dart';

List<String> dropDownItems = [
  'admin',
  'user',
];
String roleNewValue = '';

class AllUsersModelBottomSheetWidget extends StatefulWidget {
  const AllUsersModelBottomSheetWidget({
    required this.name,
    required this.email,
    required this.role,
    required this.userId,
    Key? key,
  }) : super(key: key);
  final String name;
  final String email;
  final String role;
  final String userId;
  @override
  State<AllUsersModelBottomSheetWidget> createState() =>
      _AllUsersModelBottomSheetWidgetState();
}

class _AllUsersModelBottomSheetWidgetState
    extends State<AllUsersModelBottomSheetWidget> {
  @override
  void initState() {
    super.initState();
    TextEditingControllers.allUsersNameController.text = widget.name;
    TextEditingControllers.allUsersEmailController.text = widget.email;
  }

  @override
  void dispose() {
    roleNewValue = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allUserBloc = BlocProvider.of<AllUsersBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppPadding.p10,
        right: AppPadding.p10,
        top: AppPadding.p10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: screenHeight(context) * 0.6,
        child: Column(
          children: [
            Text(
              'User Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: AppHeight.h20,
            ),
            Defaults.defaultTextField(
              prefixIcon: Icon(
                Icons.text_fields,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              controller: TextEditingControllers.allUsersNameController,
              title: 'Name',
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            Defaults.defaultTextField(
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).iconTheme.color,
              ),
              context: context,
              controller: TextEditingControllers.allUsersEmailController,
              title: 'Email',
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Role',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                StatefulBuilder(
                  builder: (context, setState) => DropdownButton<String>(
                      style: Theme.of(context).textTheme.titleLarge,
                      value: roleNewValue == '' ? widget.role : roleNewValue,
                      items: dropDownItems
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          roleNewValue = value!;
                        });
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: AppHeight.h10,
            ),
            BlocProvider.value(
              value: allUserBloc,
              child: ApplyChangesButtonWidget(
                role: widget.role,
                userId: widget.userId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
