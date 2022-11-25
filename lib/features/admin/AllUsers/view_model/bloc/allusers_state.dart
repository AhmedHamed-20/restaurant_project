part of 'allusers_bloc.dart';

class AllUsersState extends Equatable {
  final AllUsersModel? allUsersModel;
  final AllUsersRequestStatues allUsersRequestStatues;
  final AllUsersRequestStatues deleteUserByIdRequestStatues;
  final AllUsersRequestStatues allUsersGetMoreRequestStatues;
  final AllUsersUpdateDataRequestStatues updateUserDataByIdRequestStatues;
  final bool isEndOfData;
  final String errorMessage;

  const AllUsersState(
      {this.allUsersModel,
      this.deleteUserByIdRequestStatues = AllUsersRequestStatues.loading,
      this.updateUserDataByIdRequestStatues =
          AllUsersUpdateDataRequestStatues.idle,
      this.allUsersGetMoreRequestStatues = AllUsersRequestStatues.loading,
      this.isEndOfData = false,
      this.allUsersRequestStatues = AllUsersRequestStatues.loading,
      this.errorMessage = ''});

  AllUsersState copyWith({
    AllUsersRequestStatues? allUsersGetMoreRequestStatues,
    bool? isEndOfData,
    AllUsersUpdateDataRequestStatues? updateUserDataByIdRequestStatues,
    AllUsersRequestStatues? deleteUserByIdRequestStatues,
    AllUsersModel? allUsersModel,
    AllUsersRequestStatues? allUsersRequestStatues,
    String? errorMessage,
  }) {
    return AllUsersState(
      allUsersGetMoreRequestStatues:
          allUsersGetMoreRequestStatues ?? this.allUsersGetMoreRequestStatues,
      isEndOfData: isEndOfData ?? this.isEndOfData,
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
        isEndOfData,
        errorMessage,
        deleteUserByIdRequestStatues,
        updateUserDataByIdRequestStatues,
        allUsersGetMoreRequestStatues,
        identityHashCode(this),
      ];
}
