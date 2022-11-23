import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';
import 'package:resturant/features/admin/AllUsers/repositories/base/base_all_users_repository.dart';

import '../../models/all_users_model.dart';

part 'allusers_event.dart';
part 'allusers_state.dart';

class AllUsersBloc extends Bloc<AllusersEvent, AllUsersState> {
  AllUsersBloc(this.baseAllUsersRepository) : super(const AllUsersState()) {
    on<AllUsersGetEvent>(_getAllUsers);
  }
  final BaseAllUsersRepository baseAllUsersRepository;
  FutureOr<void> _getAllUsers(
      AllUsersGetEvent event, Emitter<AllUsersState> emit) async {
    final result = await baseAllUsersRepository
        .getAllUsers(AllUsersGetParams(adminToken: event.adminToken));
    result.fold((l) {
      emit(state.copyWith(
        allUsersRequestStatues: AllUsersRequestStatues.error,
        errorMessage: l.toString(),
      ));
    }, (r) {
      emit(state.copyWith(
        allUsersRequestStatues: AllUsersRequestStatues.success,
        errorMessage: '',
        allUsersModel: r,
      ));
    });
  }
}
