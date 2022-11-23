part of 'allusers_bloc.dart';

class AllUsersState extends Equatable {
  final AllUsersModel? allUsersModel;
  final AllUsersRequestStatues allUsersRequestStatues;
  final String errorMessage;

  const AllUsersState(
      {this.allUsersModel,
      this.allUsersRequestStatues = AllUsersRequestStatues.loading,
      this.errorMessage = ''});

  AllUsersState copyWith({
    AllUsersModel? allUsersModel,
    AllUsersRequestStatues? allUsersRequestStatues,
    String? errorMessage,
  }) {
    return AllUsersState(
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
