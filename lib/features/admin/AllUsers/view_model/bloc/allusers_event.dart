part of 'allusers_bloc.dart';

abstract class AllusersEvent extends Equatable {
  const AllusersEvent();
}

class AllUsersGetEvent extends AllusersEvent {
  final String adminToken;

  const AllUsersGetEvent({required this.adminToken});

  @override
  List<Object> get props => [adminToken];
}
