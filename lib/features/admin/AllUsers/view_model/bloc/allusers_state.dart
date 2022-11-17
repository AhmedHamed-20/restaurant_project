part of 'allusers_bloc.dart';

class AllusersState extends Equatable {
  final AllUsersModel? allUsersModel;
  final AllUsersRequestStatues allUsersRequestStatues;
  final String errorMessage;

  const AllusersState(
      {this.allUsersModel,
      this.allUsersRequestStatues = AllUsersRequestStatues.loading,
      this.errorMessage = ''});

  AllusersState copyWith({
    AllUsersModel? allUsersModel,
    AllUsersRequestStatues? allUsersRequestStatues,
    String? errorMessage,
  }) {
    return AllusersState(
      allUsersModel: allUsersModel ?? this.allUsersModel,
      allUsersRequestStatues:
          allUsersRequestStatues ?? this.allUsersRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [allUsersModel, allUsersRequestStatues, errorMessage];
}
