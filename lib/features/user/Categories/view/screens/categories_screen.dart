import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/core/services/service_locator.dart';

import '../../../../../core/const/app_routes_names.dart';
import '../../../../../core/utls/utls.dart';
import '../../view_model/bloc/categories_bloc.dart';

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
            return GridView.builder(
              itemCount: state.categoryModel!.categoryData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    CategoriesBloc categoriesBloc =
                        BlocProvider.of<CategoriesBloc>(context);
                    Navigator.pushNamed(
                      context,
                      AppRoutesNames.categoryRecipesScreen,
                      arguments: state.categoryModel!.categoryData[index].name,
                    );
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        state.categoryModel!.categoryData[index].name,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            );
          case CategoryRequestStatues.error:
            return Center(child: Text(state.errorMessage));
        }
      }),
    );
  }
}
