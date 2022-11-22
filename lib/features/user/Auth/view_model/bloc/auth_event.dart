part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  const SignUpEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.passwordConfirmation});

  @override
  List<Object?> get props => [email, password, name, passwordConfirmation];
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  const ForgetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class AccessTokenCacheEvent extends AuthEvent {
  final String accessToken;
  final bool isLogin;

  const AccessTokenCacheEvent(
      {required this.accessToken, required this.isLogin});

  @override
  List<Object?> get props => [accessToken, isLogin];
}

class LoginPasswordVisibilityEvent extends AuthEvent {
  final bool loginPasswordVisibility;

  const LoginPasswordVisibilityEvent({required this.loginPasswordVisibility});

  @override
  List<Object?> get props => [loginPasswordVisibility];
}

class SignUpPasswordVisibilityEvent extends AuthEvent {
  final bool signUpPasswordVisibility;

  const SignUpPasswordVisibilityEvent({required this.signUpPasswordVisibility});

  @override
  List<Object?> get props => [signUpPasswordVisibility];
}
