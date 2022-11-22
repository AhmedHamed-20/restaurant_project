part of 'admin_auth_bloc.dart';

abstract class AdminAuthEvent extends Equatable {
  const AdminAuthEvent();
}

class LoginAdminEvent extends AdminAuthEvent {
  final String email;
  final String password;

  const LoginAdminEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LoginAdminPasswordVisibiltyEvent extends AdminAuthEvent {
  final bool loginAdminPasswordVisibility;
  const LoginAdminPasswordVisibiltyEvent(
      {required this.loginAdminPasswordVisibility});

  @override
  List<Object> get props => [loginAdminPasswordVisibility];
}
