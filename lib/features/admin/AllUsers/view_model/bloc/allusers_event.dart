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

class UserDeleteEvent extends AllusersEvent {
  final String adminToken;
  final String userId;

  const UserDeleteEvent({
    required this.adminToken,
    required this.userId,
  });

  @override
  List<Object> get props => [adminToken, userId];
}

class UserDataUpdateByIdEvent extends AllusersEvent {
  final String adminToken;
  final String userId;
  final String name;
  final String email;
  final String role;

  const UserDataUpdateByIdEvent({
    required this.adminToken,
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object> get props => [adminToken, userId, name, email, role];
}
