part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthModel? signUpModel;
  final AuthModel? loginModel;
  final AuthRequestStatues loginRequestStatues;
  final AuthRequestStatues signUpRequestStatues;
  final AuthRequestStatues forgetPasswordRequestStatues;
  final String errorMessage;

  const AuthState(
      {this.signUpModel,
      this.loginModel,
      this.forgetPasswordRequestStatues = AuthRequestStatues.idle,
      this.loginRequestStatues = AuthRequestStatues.idle,
      this.signUpRequestStatues = AuthRequestStatues.idle,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthRequestStatues? forgetPasswordRequestStatues,
    AuthModel? signUpModel,
    AuthModel? loginModel,
    AuthRequestStatues? loginRequestStatues,
    AuthRequestStatues? signUpRequestStatues,
    String? errorMessage,
  }) {
    return AuthState(
      forgetPasswordRequestStatues:
          forgetPasswordRequestStatues ?? this.forgetPasswordRequestStatues,
      signUpModel: signUpModel ?? this.signUpModel,
      loginModel: loginModel ?? this.loginModel,
      loginRequestStatues: loginRequestStatues ?? this.loginRequestStatues,
      signUpRequestStatues: signUpRequestStatues ?? this.signUpRequestStatues,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        signUpModel,
        loginModel,
        loginRequestStatues,
        signUpRequestStatues,
        forgetPasswordRequestStatues,
        errorMessage,
      ];
}
