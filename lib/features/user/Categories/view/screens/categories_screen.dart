import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/services/service_locator.dart';

import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/categories_bloc.dart';
import '../widgets/main_categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<CategoriesBloc>()..add(const AllCategoriesEvent()),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
        switch (state.categoriesRequestState) {
          case CategoryRequestStatues.loading:
            return const Center(child: CircularProgressIndicator());
          case CategoryRequestStatues.success:
            return const MainCategoriesWidget();
          case CategoryRequestStatues.error:
            return Center(child: Text(state.errorMessage));
        }
      }),
    );
  }
}
