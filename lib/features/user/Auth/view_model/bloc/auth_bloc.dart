import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:resturant/core/utls/utls.dart';

import '../../models/auth_model.dart';
import '../../repositories/base/base_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.baseAuthRepository) : super(const AuthState()) {
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
    on<ForgetPasswordEvent>(_forgetPassword);
  }

  final BaseAuthRepository baseAuthRepository;
  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginRequestStatues: AuthRequestStatues.loading));
    final result = await baseAuthRepository
        .login(LoginParams(event.email, event.password));

    result.fold((l) {
      emit(state.copyWith(
        loginRequestStatues: AuthRequestStatues.error,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        loginRequestStatues: AuthRequestStatues.success,
        errorMessage: '',
        loginModel: r,
      ));
    });
  }

  FutureOr<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signUpRequestStatues: AuthRequestStatues.loading));
    final result = await baseAuthRepository.signUp(SignUpParams(
      email: event.email,
      name: event.name,
      password: event.password,
      passwordConfirmation: event.passwordConfirmation,
    ));

    result.fold((l) {
      emit(state.copyWith(
        signUpRequestStatues: AuthRequestStatues.error,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        signUpRequestStatues: AuthRequestStatues.success,
        errorMessage: '',
        signUpModel: r,
      ));
    });
  }

  FutureOr<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
        forgetPasswordRequestStatues: AuthRequestStatues.loading));
    final result = await baseAuthRepository
        .forgetPassword(ForgetPasswordParams(event.email));

    result.fold((l) {
      emit(state.copyWith(
        forgetPasswordRequestStatues: AuthRequestStatues.error,
        errorMessage: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        forgetPasswordRequestStatues: AuthRequestStatues.success,
        errorMessage: '',
      ));
    });
  }
}
