import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/admin/Category/models/admin_category_model.dart';
import 'package:resturant/features/admin/Category/repository/base/base_admin_category_repository.dart';

part 'admin_category_event.dart';
part 'admin_category_state.dart';

class AdminCategoryBloc extends Bloc<AdminCategoryEvent, AdminCategoryState> {
  AdminCategoryBloc(this.baseAdminCategoryRepository)
      : super(const AdminCategoryState()) {
    on<GetAdminCategoriesEvent>(_getCategories);
    on<AddAdminCategoryEvent>(_addCategory);
    on<UpdateAdminCategoryEvent>(_updateCategory);
    on<DeleteAdminCategoryEvent>(_deleteCategory);
  }
  final BaseAdminCategoryRepository baseAdminCategoryRepository;
  FutureOr<void> _getCategories(
      GetAdminCategoriesEvent event, Emitter<AdminCategoryState> emit) async {
    final result = await baseAdminCategoryRepository.getCategories();
    result.fold(
      (failure) => emit(state.copyWith(
        errorMessage: failure.message,
        categoryAdminRequestStatues: CategoryAdminRequestStatues.error,
      )),
      (data) => emit(state.copyWith(
        categoryModel: data,
        categoryAdminRequestStatues: CategoryAdminRequestStatues.success,
      )),
    );
  }

  FutureOr<void> _addCategory(
      AddAdminCategoryEvent event, Emitter<AdminCategoryState> emit) async {
    final result = await baseAdminCategoryRepository.addCategory(
        CategoryAdminAddParams(name: event.name, adminToken: event.adminToken));
    result.fold(
        (failure) => emit(state.copyWith(
              errorMessage: failure.message,
              categoryAdminAddRequestStatues:
                  CategoryAdminAddRequestStatues.error,
            )), (data) {
      emit(state.copyWith(
        errorMessage: '',
        categoryAdminAddRequestStatues: CategoryAdminAddRequestStatues.success,
      ));

      add(GetAdminCategoriesEvent());
    });
  }

  FutureOr<void> _updateCategory(
      UpdateAdminCategoryEvent event, Emitter<AdminCategoryState> emit) async {
    final result = await baseAdminCategoryRepository.updateCategory(
      CategoryAdminUpdateParams(
        name: event.name,
        adminToken: event.adminToken,
        id: event.id,
      ),
    );
    result.fold(
        (failure) => emit(state.copyWith(
              errorMessage: failure.message,
              categoryAdminUpdateRequestStatues:
                  CategoryAdminUpdateRequestStatues.error,
            )), (data) {
      emit(state.copyWith(
        errorMessage: '',
        categoryAdminUpdateRequestStatues:
            CategoryAdminUpdateRequestStatues.success,
      ));

      add(GetAdminCategoriesEvent());
    });
  }

  FutureOr<void> _deleteCategory(
      DeleteAdminCategoryEvent event, Emitter<AdminCategoryState> emit) async {
    final result = await baseAdminCategoryRepository.deleteCategory(
      CategoryAdminDeleteParams(
        adminToken: event.adminToken,
        id: event.id,
      ),
    );
    result.fold(
        (failure) => emit(state.copyWith(
              errorMessage: failure.message,
              categoryAdminDeleteRequestStatues:
                  CategoryAdminDeleteRequestStatues.error,
            )), (data) {
      emit(state.copyWith(
        errorMessage: '',
        categoryAdminDeleteRequestStatues:
            CategoryAdminDeleteRequestStatues.success,
      ));
      add(GetAdminCategoriesEvent());
    });
  }
}
