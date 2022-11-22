import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/const/const.dart';
import 'package:resturant/core/widget/defaults.dart';

import '../../../../../const/text_editing_controllers.dart';
import '../../../view_model/bloc/layout_bloc.dart';
import '../../widgets/logout_alert_dialog_widget.dart';
import '../../widgets/udate_button_widget.dart';
import '../../widgets/update_password_button_widget.dart';

class ActiveUserDataInfoScreen extends StatelessWidget {
  const ActiveUserDataInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          'Active User Data',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const LogoutAlertDialogWidget());
            },
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              BlocBuilder<LayoutBloc, LayoutState>(
                builder: (context, state) {
                  return CircleAvatar(
                    radius: AppRadius.r70,
                    backgroundImage: NetworkImage(
                      state.activeUser!.photo,
                    ),
                  );
                },
              ),
              const SizedBox(height: AppHeight.h10),
              BlocConsumer<LayoutBloc, LayoutState>(
                listener: (context, state) {},
                builder: (context, state) {
                  TextEditingControllers.activeUserDataNameController.text =
                      state.activeUser!.name;
                  return Defaults.defaultTextField(
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    context: context,
                    controller:
                        TextEditingControllers.activeUserDataNameController,
                    title: 'Name',
                  );
                },
              ),
              const SizedBox(
                height: AppHeight.h10,
              ),
              BlocConsumer<LayoutBloc, LayoutState>(
                listener: (context, state) {},
                builder: (context, state) {
                  TextEditingControllers.activeUserDataEmailController.text =
                      state.activeUser!.email;
                  return Defaults.defaultTextField(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    context: context,
                    controller:
                        TextEditingControllers.activeUserDataEmailController,
                    title: 'Email',
                  );
                },
              ),
              const SizedBox(
                height: AppHeight.h20,
              ),
              const UpdateButtonWidget(),
              const SizedBox(
                height: AppHeight.h10,
              ),
              const UpdatePasswordButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
