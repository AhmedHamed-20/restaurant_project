part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthModel? signUpModel;
  final AuthModel? loginModel;
  final AuthRequestStatues loginRequestStatues;
  final AuthRequestStatues signUpRequestStatues;
  final ForgetPasswordRequestStatues forgetPasswordRequestStatues;
  final String errorMessage;
  final bool loginPasswordVisibility;
  final bool signUpPasswordVisibility;
  const AuthState(
      {this.signUpModel,
      this.loginModel,
      this.loginPasswordVisibility = true,
      this.signUpPasswordVisibility = true,
      this.forgetPasswordRequestStatues = ForgetPasswordRequestStatues.idle,
      this.loginRequestStatues = AuthRequestStatues.idle,
      this.signUpRequestStatues = AuthRequestStatues.idle,
      this.errorMessage = ''});

  AuthState copyWith({
    bool? loginPasswordVisibility,
    bool? signUpPasswordVisibility,
    ForgetPasswordRequestStatues? forgetPasswordRequestStatues,
    AuthModel? signUpModel,
    AuthModel? loginModel,
    AuthRequestStatues? loginRequestStatues,
    AuthRequestStatues? signUpRequestStatues,
    String? errorMessage,
  }) {
    return AuthState(
      loginPasswordVisibility:
          loginPasswordVisibility ?? this.loginPasswordVisibility,
      signUpPasswordVisibility:
          signUpPasswordVisibility ?? this.signUpPasswordVisibility,
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
        loginPasswordVisibility,
        signUpPasswordVisibility,
      ];
}
