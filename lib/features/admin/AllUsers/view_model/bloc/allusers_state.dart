part of 'allusers_bloc.dart';

class AllUsersState extends Equatable {
  final AllUsersModel? allUsersModel;
  final AllUsersRequestStatues allUsersRequestStatues;
  final AllUsersRequestStatues deleteUserByIdRequestStatues;
  final AllUsersUpdateDataRequestStatues updateUserDataByIdRequestStatues;

  final String errorMessage;

  const AllUsersState(
      {this.allUsersModel,
      this.deleteUserByIdRequestStatues = AllUsersRequestStatues.loading,
      this.updateUserDataByIdRequestStatues =
          AllUsersUpdateDataRequestStatues.idle,
      this.allUsersRequestStatues = AllUsersRequestStatues.loading,
      this.errorMessage = ''});

  AllUsersState copyWith({
    AllUsersUpdateDataRequestStatues? updateUserDataByIdRequestStatues,
    AllUsersRequestStatues? deleteUserByIdRequestStatues,
    AllUsersModel? allUsersModel,
    AllUsersRequestStatues? allUsersRequestStatues,
    String? errorMessage,
  }) {
    return AllUsersState(
      updateUserDataByIdRequestStatues: updateUserDataByIdRequestStatues ??
          this.updateUserDataByIdRequestStatues,
      deleteUserByIdRequestStatues:
          deleteUserByIdRequestStatues ?? this.deleteUserByIdRequestStatues,
      allUsersModel: allUsersModel ?? this.allUsersModel,
      allUsersRequestStatues:
          allUsersRequestStatues ?? this.allUsersRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        allUsersModel,
        allUsersRequestStatues,
        errorMessage,
        deleteUserByIdRequestStatues,
        updateUserDataByIdRequestStatues,
      ];
}
