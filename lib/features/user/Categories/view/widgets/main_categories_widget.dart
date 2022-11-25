import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/features/user/Categories/view_model/bloc/categories_bloc.dart';

import '../../../../../core/const/app_routes_names.dart';
import '../../../../../core/const/params.dart';

int categoriesPage = 2;

class MainCategoriesWidget extends StatefulWidget {
  const MainCategoriesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MainCategoriesWidget> createState() => _MainCategoriesWidgetState();
}

class _MainCategoriesWidgetState extends State<MainCategoriesWidget> {
  final ScrollController scrollController = ScrollController();
  bool isEndOfData = false;
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          isEndOfData == false) {
        BlocProvider.of<CategoriesBloc>(context)
            .add(CategoriesMoreGetEvent(categoriesPage.toString()));
        categoriesPage++;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    categoriesPage = 2;
    isEndOfData = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryBloc = BlocProvider.of<CategoriesBloc>(context);
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        isEndOfData = state.isEndOfData;
      },
      builder: (context, state) {
        return GridView.builder(
          controller: scrollController,
          itemCount: state.categoryModel!.categoryData.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            if (index < state.categoryModel!.categoryData.length) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutesNames.categoryRecipesScreen,
                    arguments: CategoryRecipesScreenParams(
                        state.categoryModel!.categoryData[index].name,
                        categoryBloc),
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
            } else {
              return state.isEndOfData
                  ? const SizedBox.shrink()
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }
          },
        );
      },
    );
  }
}
