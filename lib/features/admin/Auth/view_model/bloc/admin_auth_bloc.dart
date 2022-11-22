import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/features/admin/Auth/models/auth_admin_model.dart';
import 'package:resturant/features/admin/Auth/repository/base/base_admin_auth_repositroy.dart';

import '../../../../../core/utls/utls.dart';

part 'admin_auth_event.dart';
part 'admin_auth_state.dart';

class AdminAuthBloc extends Bloc<AdminAuthEvent, AdminAuthState> {
  AdminAuthBloc(this.baseAdminAuthRepository) : super(const AdminAuthState()) {
    on<LoginAdminPasswordVisibiltyEvent>(_loginAdminPasswordVisibilty);
    on<LoginAdminEvent>(_loginAdmin);
  }
  final BaseAdminAuthRepository baseAdminAuthRepository;
  FutureOr<void> _loginAdminPasswordVisibilty(
      LoginAdminPasswordVisibiltyEvent event, Emitter<AdminAuthState> emit) {
    emit(state.copyWith(
        loginAdminPasswordVisibility: event.loginAdminPasswordVisibility));
  }

  FutureOr<void> _loginAdmin(
      LoginAdminEvent event, Emitter<AdminAuthState> emit) async {
    emit(state.copyWith(
        adminAuthRequestStatues: AdminAuthRequestStatues.loading));
    final result = await baseAdminAuthRepository
        .loginAdmin(LoginAdminParams(event.email, event.password));
    result.fold((l) {
      emit(state.copyWith(
          adminAuthRequestStatues: AdminAuthRequestStatues.error,
          errorMessage: l.toString()));
    }, (r) {
      if (r.role == 'admin') {
        emit(state.copyWith(
            adminAuthRequestStatues: AdminAuthRequestStatues.success,
            adminModel: r));
      } else {
        emit(state.copyWith(
            adminAuthRequestStatues: AdminAuthRequestStatues.error,
            errorMessage: 'you are not admin'));
      }
    });
  }
}
