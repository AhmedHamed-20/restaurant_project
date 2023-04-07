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
    on<UserDeleteEvent>(_deleteUserByIdAndGetAllUsers);
    on<UserDataUpdateByIdEvent>(_updateUserDataByIdAndGetAllUsers);
    on<MoreUsersGetEvent>(_getMoreUsers);
  }
  final BaseAllUsersRepository baseAllUsersRepository;
  FutureOr<void> _getAllUsers(
      AllUsersGetEvent event, Emitter<AllUsersState> emit) async {
    final result = await baseAllUsersRepository
        .getAllUsers(AllUsersGetParams(adminToken: event.adminToken, page: 1));
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

  FutureOr<void> _deleteUserByIdAndGetAllUsers(
      UserDeleteEvent event, Emitter<AllUsersState> emit) async {
    final result = await baseAllUsersRepository.deleteUserById(
      DeleteUserByIdParams(
        adminToken: event.adminToken,
        userId: event.userId,
      ),
    );

    result.fold((l) {
      emit(state.copyWith(
        deleteUserByIdRequestStatues: AllUsersRequestStatues.error,
        errorMessage: l.toString(),
      ));
    }, (r) {
      emit(state.copyWith(
        deleteUserByIdRequestStatues: AllUsersRequestStatues.success,
        errorMessage: '',
      ));

      add(AllUsersGetEvent(adminToken: event.adminToken, page: 1));
    });
  }

  FutureOr<void> _updateUserDataByIdAndGetAllUsers(
      UserDataUpdateByIdEvent event, Emitter<AllUsersState> emit) async {
    emit(state.copyWith(
      updateUserDataByIdRequestStatues:
          AllUsersUpdateDataRequestStatues.loading,
    ));
    final result = await baseAllUsersRepository.udpateUserDataById(
      UpdateUserDataByIdParams(
        adminToken: event.adminToken,
        name: event.name,
        userId: event.userId,
        email: event.email,
        role: event.role,
      ),
    );
    result.fold((l) {
      emit(state.copyWith(
        updateUserDataByIdRequestStatues:
            AllUsersUpdateDataRequestStatues.error,
        errorMessage: l.toString(),
      ));
    }, (r) {
      emit(state.copyWith(
        updateUserDataByIdRequestStatues:
            AllUsersUpdateDataRequestStatues.success,
        errorMessage: '',
      ));

      add(AllUsersGetEvent(adminToken: event.adminToken, page: 1));
    });
  }

  FutureOr<void> _getMoreUsers(
      MoreUsersGetEvent event, Emitter<AllUsersState> emit) async {
    final result = await baseAllUsersRepository.getAllUsers(
      AllUsersGetParams(
        adminToken: event.adminToken,
        page: event.page,
      ),
    );

    result.fold((l) {
      emit(state.copyWith(
        allUsersGetMoreRequestStatues: AllUsersRequestStatues.error,
        errorMessage: l.toString(),
        isEndOfData: false,
      ));
    }, (r) {
      if (r.results == 0) {
        emit(state.copyWith(
          errorMessage: '',
          isEndOfData: true,
          allUsersGetMoreRequestStatues: AllUsersRequestStatues.success,
        ));
      } else if (r.results == 10) {
        AllUsersModel myAllUsersModel;
        myAllUsersModel = state.allUsersModel!;

        myAllUsersModel.usersData.addAll(r.usersData);

        emit(state.copyWith(
          errorMessage: '',
          allUsersModel: myAllUsersModel,
          isEndOfData: false,
          allUsersGetMoreRequestStatues: AllUsersRequestStatues.success,
        ));
      } else {
        AllUsersModel myAllUsersModel = state.allUsersModel!;
        myAllUsersModel.usersData.addAll(r.usersData);
        emit(state.copyWith(
          errorMessage: '',
          allUsersModel: myAllUsersModel,
          isEndOfData: true,
          allUsersGetMoreRequestStatues: AllUsersRequestStatues.success,
        ));
      }
    });
  }
}
