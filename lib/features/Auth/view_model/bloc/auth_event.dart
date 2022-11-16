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
